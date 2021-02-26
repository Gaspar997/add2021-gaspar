#!/usr/bin/env ruby
#GasparEstevez

if ARGV[0].nil?
  puts "Error:"
  puts "  #{$0} Usa --help para ver la ayuda!"
  exit 1
end

if ARGV[0]=="--help"
   puts "Usage:
		systemctl [OPTIONS] [FILENAME]
	Options:
		--help,mostrar esta ayuda.
		--version, mostrar informacion sobre el autor del script
			   y fecha de creacion.
		--status FILENAME, comprueba si se puede instalar/desinstalar.
		--run FILENAME, instala/desinstala el software indicado.
	Description:

		Este script se encarga de instalar/desinstalar
		el software indicado en el fichero FILENAME.
		Ejemplo de FILENAME:
		tree:install
		nmap:install
		atomix:remove"
  exit 1
end

if ARGV[0]=="--version"

  puts "Autor: Gaspar Estévez Hernández
	fecha de creacion: 22/02/21"
  exit 1
end

if ARGV[0]=='--status'
  a = `cat #{ARGV[1]}`
  b = a.split("\n")
  b.each do |i|
    d=i.split(":")
    c = `zypper info #{d[0]}|grep Instalado|grep Sí |wc -l`.chop
    if c == "1"
      puts " Estado del paquete #{d[0]} (Instalado)"
    else
      puts " Estado del paquete #{d[0]} (No instalado)"
    end
  end
end

if ARGV[0]=='--run'
  usuario=`whoami`.chop
  if usuario !="root"
    puts"[ERROR] La opcion run  tiene que ser ejecutada como root!!"
    exit 1
  end

  a = `cat #{ARGV[1]}`
  b = a.split("\n")
  b.each do |i|
  d=i.split(":")
  if d[1]=="install"
      puts" Instalar #{d[0]}"
      puts" Instalando... #{d[0]}"
      system("zypper install -y #{d[0]}") 
      puts" #{d[0]} instalado correctamente!!"
    else
      puts" Desinstalar #{d[0]}"
      puts" Desinstalando... #{d[0]}"
      system("zypper remove -y  #{d[0]}")
      puts" #{d[0]} desinstalado correctamente!!"
    end
  end
end
   

 





