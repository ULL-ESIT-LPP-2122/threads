mutex = Mutex.new
cv = ConditionVariable.new

a = Thread.new {
   mutex.synchronize {
      print "A: Esta en una region critica, esperando por cv\n"
      cv.wait(mutex)
      print "A: Esta en la region critica de nuevo!. Sigue\n"
   }
}

print "En medio\n"

b = Thread.new {
   mutex.synchronize {
      puts "B: Esta en la region critica pero tiene a cv"
      cv.signal
      puts "B: Esta en la region critica, Saliendo"
   }
}

a.join
b.join

print "Al final\n"

