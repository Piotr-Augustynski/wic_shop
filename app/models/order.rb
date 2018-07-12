class Order < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries

  belongs_to :shipping_type
  has_many :line_items
  has_many :transitions, class_name: 'OrderTransition', autosave: false
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state, to: :state_machine

  def state_machine
    @state_machine ||= OrderStateMachine.new(self, transition_class: OrderTransition,
                                             association_name: :transitions)
  end

  def full_cost
    line_items.map { |e| e.full_price }.sum + shipping_cost
  end

  def self.transition_state
    OrderTransition
  end

  def self.initial_class
    OrderStateMachine.initial_state
  end

  def self.transition_name
    :transitions
  end
end
