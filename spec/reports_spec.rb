require 'spec_helper'

RSpec.describe Reports do
  let!(:report) { create(:report, from: 2.months.ago, to: 1.month.ago) }

  subject { described_class.new(payday: payday) }

  let(:payday) { 3.days.ago }

  it 'returns a report' do
    expect(subject.call).to be_a(Report)
  end

  it 'saves a monthly report' do
    expect { subject.call }.to change { Report.count }.by(1)
  end

  it 'adds existing unreported expenses' do
    create_list(:expense, 2, transaction_date: 5.days.ago, report: nil)

    expect(subject.call.expenses.reload.count).to eq(2)
  end

  it 'does not add reported or after payday expenses' do
    create_list(:expense, 2, transaction_date: 1.day.from_now, report: nil)
    create_list(:expense, 2, :with_report, transaction_date: 5.days.ago)

    expect(subject.call.expenses.reload.count).to eq(0)
  end

  it 'report\'s to date is payday - 1.day' do
    expect(subject.call.to).to eq(payday.to_date - 1.day)
  end

  it 'report\'s from date is last report\'s to date' do
    last_report = create(:report, to: 5.days.ago)

    expect(subject.call.from.to_date).to eq(last_report.to + 1.day)
  end

  it 'report\'s from date is a date of the first unreported expense if there is no previous report' do
    report.destroy!
    expense = create(:expense)

    expect(subject.call.from.to_date).to eq(expense.transaction_date)
  end
end
