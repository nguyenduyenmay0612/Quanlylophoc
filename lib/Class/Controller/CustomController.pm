package Class::Controller::CustomController;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome ($self) {

  # Render template "example/welcome.html.ep" with message
  #$self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
  $self->render(template =>'myTemplates/homepage', msg => 'Welcome to My personal website!');
}

1;
