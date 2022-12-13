package Class;
use Mojo::Base 'Mojolicious', -signatures;
#use Mojo::mysql;
#use MyApp::Model::DB ;


# Invoking Database handle 
my $self = shift;

=c$self->helper(mysql => 
sub { state $mysql = Mojo::mysql->new(shift->config('mysql')) });

$self->helper(dbhandle => 
sub { state $vikidb = Class::Model::Database->new(mysql => shift->mysql) });
=cut
# This method will run once at server start
sub startup  {

  my $self = shift;


  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('CustomController#disLogin'); 
  $r->post('/index')->to('CustomController#welcome');
  $r->any('/logout')->to('CustomController#disLogin');


}

1;
