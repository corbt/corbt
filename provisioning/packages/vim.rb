package :vim do 
  apt "vim", sudo: true
  verify { has_executable "vim" }
end