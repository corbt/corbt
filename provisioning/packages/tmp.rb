package :tmp do
	runner 'mkdir ~/tmp'
	verify { has_directory '~/tmp' }
end