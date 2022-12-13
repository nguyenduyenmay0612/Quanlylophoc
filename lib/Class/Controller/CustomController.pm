package Class::Controller::CustomController;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use mojo::mysql;
my $mysql = Mojo::mysql->strict_mode('mysql://root@localhost/class');

use Mojo::mysql::Database;
use Mojo::mysql::Results;
use Mojolicious::Plugins;
#use Mojolicious::Plugin::Authentication

my $db = Mojo::mysql::Database->new(mysql => $mysql);
use base 'DBIx::Class::ResultSet';
#my $results = Mojo::mysql::Results->new(db => $db, sth => $sth);


# This action will render a template
sub welcome  {
  my $self = shift;
  my $username = $self->param('username');
  my $pass = $self->param('pass'); 
  
  #if ( ! $username || ! $pass) {
    #$self ->flash(error => 'Username and Password la bat buoc');
    #$self -> render(template => 'myTemplates/login');
  #}
# my $dbh = $self->app->{_dbh};
   # my $results= $dbh->query('users')->where (
    #    username => $username,
    #    pass => $pass
        #);
    #$self ->flash(message => 'thanh cong');
   # $self->render(template =>'myTemplates/homepage',msg => 'Welcome to My personal website!'); 
  my $auth_key =plugin->authenticate($username, $pass );

    if ( $auth_key )  {
        $self->flash( msg => 'Login Success.');
        $self->render(template =>'myTemplates/homepage',msg => 'Welcome to My personal website!'); 
    }
    else {
        $self->flash( error => 'Invalid username or password.');
        $self->render(template =>'myTemplates/login',msg => 'Welcome to My personal website!'); 
    }

  # Render template "example/welcome.html.ep" with message
  #$self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
  #$self->render(template =>'myTemplates/homepage', msg => 'Welcome to My personal website!');
}

sub disLogin {


  my $self = shift;

  $self -> render(template => 'myTemplates/login', error => $self->flash('error'), message => $self->flash('message'));
  
 
}


=sub validUserCheck {

  my $self = shift;

    my %validUsers = ( "May1" => "welcome123",
                      "MAY1" => "welcome1"

    );
  my $user = uc $self->param('username');
  my $password = uc $self->param('pass'); 

  if($validUsers{$user}) {
    if($validUsers{$user} eq $password) {
         $self ->session(is_auth => 1);
         $self ->session(username => $user);
         $self ->session(expriration => 600);

         &welcome($self);

    } else{
          $self -> render(template => 'myTemplates/login', error_message => "Invalid password, please try again");
    }
  }else {
          $self -> render(template => 'myTemplates/login', error_message => "You are not a resistered user, please get the hell out of here");

  }

}

sub alreadyLoggedIn{

  my $self = shift;
  return 1 if $self->session('is_auth');
          $self -> render(template => 'myTemplates/login', error_message => "You are not logged in, please log in Website");
          return;
}
=cut

sub logout {

 my $self = shift;

  $self -> render(template => 'myTemplates/login', error_message =>"");
}

1;
