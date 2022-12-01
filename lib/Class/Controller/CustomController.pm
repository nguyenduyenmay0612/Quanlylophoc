package Class::Controller::CustomController;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  #$self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
  $self->render(templates =>'myTemplates/homepage', msg => 'Welcome to My personal website!');
}

sub displayLogin {

  my $self = shift;

  if(&alreadyLoggedIn($self)) {

    &welcome($self);
  }else {
    $self -> render(templates => "myTemplates/login", error_message =>"");
  }

}

sub validUserCheck {

  my $self = shift;

    my %validUsers = ( "may" => "welcome",
                       "may1" => "welcome1"
    );

  my $user = uc $self->param('username');
  my $password = $self->param('pass'); 

  if($validUsers{$user}) {
    if($validUsers{$user} eq $password) {
         $self ->session(is_auth => 1);
         $self ->session(username => $user);
         $self ->session(expriration => 600);

         &welcome($self);

    } else{
          $self -> render(templates => "myTemplates/login", error_message => "Invalid password, please try again");
    }
  } else {
          $self -> render(templates => "myTemplates/login", error_message => "You are not a resistered user, please get the hell out of here");

  }

}

sub alreadyLoggedIn {

  my $self = shift;
  return 1 if $self->session('is_auth');
          $self->render(templates => "myTemplates/login", error_message => "You are not logged in, please log in Website");
          return;
}

sub logout {

  my $self = shift;

  $self->session(expires => 1);
  $self->session(templates => "myTemplates/logout");
}

1;
