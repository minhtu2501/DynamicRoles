namespace 'permissions' do
  desc "Loading all models and their methods in permissions table."
  task permissions: :environment do
    Rails.application.eager_load!
    ApplicationController.subclasses.each do |controller|
      controller.instance_methods(false).each do |method|
        unless controller.name == "DeviseController"
          name, cancan_action = eval_cancan_action(method)
          write_permission(controller.name, cancan_action, name) 
        end 
      end
    end
  end
end

def eval_cancan_action(action)
  case action.to_s
  when "index"
    name = 'read'
    cancan_action = "index"
    action_desc = I18n.t :index
  when "show"
    name = 'show'
    cancan_action = "show"
    action_desc = I18n.t :show
  when "new", "create"
    name = 'create'
    cancan_action = "create"
    action_desc = I18n.t :create
  when "edit", "update"
    name = 'update'
    cancan_action = "update"
    action_desc = I18n.t :update
  when "delete", "destroy"
    name = 'delete'
    cancan_action = "destroy"
    action_desc = I18n.t :destroy
  else
    name = action.to_s
    cancan_action = action.to_s
    action_desc = "Other: " << cancan_action
  end
  return name, cancan_action
  
end

def write_permission(modell, cancan_action, name)
  # byebug
  permission  = Permission.find_by(subject_class: modell, action: cancan_action)
  unless permission
    permission = Permission.create(subject_class: modell, action: cancan_action, name: name)
  end
end