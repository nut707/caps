class Ability
  include CanCan::Ability

  def initialize(user)
    if user.superadmin?
      can :manage, :all
    elsif user.admin?
      can :manage, :all
      cannot :manage, User
    else
      can :read, :all
      can [:edit, :update, :my, :new, :create], Profile, user_id: user.id
      can [:my, :autocomplete_profile_last_name], Publication
      cannot :index, Publication

      if user.profile.present?
        can [:new, :create, :edit, :update, :add_author, :add_author_update, :author_remove, :destroy], Publication, author_id: user.profile.id

        can :manage, ExternalAuthor, :publication => { author_id: user.profile.id }

        can [:my, :new, :create], Project
        cannot [:index, :show], Project 
        can :show, Project, :participants => {profile_id: user.profile.id}
        can [:edit, :update, :destroy, :add_publication, :remove_publication, :change_status, :show], Project, status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}


        can [:add_report, :new, :create], Event, :project => {:participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}
        can [:edit, :update, :destroy], Event, :project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}

        can [:manage, :autocomplete_profile_last_name], Participant, :project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}
        can :role_fields_form, Participant

        can [:new, :create, :edit, :destroy, :update], OtherEvent, :project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}

        can [:new, :create, :edit, :destroy, :update], EduProgram, :project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}

        can [:new, :create, :edit, :destroy, :update], Research, :project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}

        can [:new, :create, :edit, :destroy, :update], Course, :project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}

        can [:new, :create, :edit, :destroy, :update], Student, :project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}

        can [:new, :create, :edit, :destroy, :update], Teacher, :course => {:project => {status: 'draft', :participants => {profile_id: user.profile.id, role_id: Role.find_by(name:'Руководитель проекта').id}}}
      end
    end
  end
end
