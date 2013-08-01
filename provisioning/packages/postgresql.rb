package :postgres, :provides => :database do
  description 'PostgreSQL database'
  requires :postgres_core, :postgres_user, :postgres_database
end

package :postgres_core do
  apt %w( postgresql postgresql-client libpq-dev ), sudo: true
  
  verify do
    has_executable 'psql'
    has_apt 'postgresql'
    has_apt 'postgresql-client'
    has_apt 'libpq-dev'
  end
end
  
package :postgres_user do
  runner %{echo "CREATE ROLE deploy WITH LOGIN ENCRYPTED PASSWORD 'corbt_db_password';" | sudo -u postgres psql}
  
  verify do
    @commands << "echo 'SELECT ROLNAME FROM PG_ROLES' | sudo -u postgres psql | grep deploy"
  end
end

package :postgres_database do
  requires :postgres_user
  runner "sudo -u postgres createdb --owner=deploy corbt_site"
  
  verify do
    @commands << "sudo -u postgres psql -l | grep corbt_site"
  end  
end

package :postgres_autostart do
  description "PostgreSQL: Autostart on reboot"
  requires :postgres_core
  
  runner '/usr/sbin/update-rc.d postgresql defaults', sudo: true
end