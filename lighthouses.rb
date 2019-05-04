# Welcome to Sonic Pi v2.10
# Lighthouses II
# lighthouses.rb
# Dawn Erb
# August 27, 2016

# NANOGrav millisecond pulsars from http://nanograv.org/astronomers/data.html
# pulsar frequencies converted to MIDI data values
# see https://en.wikipedia.org/wiki/MIDI_Tuning_Standard

J0023p0923 = 63.9074
J0030p0451 = 55.8060
J0340p4130 = 62.5435
J0613m0200 = 63.8507
J0645p5158 = 45.4650
J0931m1902 = 56.6436
J1012p5307 = 54.4723
J1024m0719 = 54.8046
J1455m3330 = 47.2347
J1600m3053 = 61.0371
J1614m2230 = 63.3489
J1640p2224 = 56.7184
J1643m1224 = 56.7184
J1713p0747 = 56.9068
J1738p0333 = 52.6319
J1741p1351 = 60.3304
J1744m1134 = 58.9127
J1747m4036 = 74.5435
J1853p1303 = 58.8279
B1855p09 = 54.1463
J1903p0327 = 69.9611
J1909m3744 = 64.4845
J1910p1256 = 55.4193
J1918m0642 = 47.9876
J1923p2515 = 60.1925
B1937p21 = 75.5145
J1944p0907 = 54.7043
J1949p3106 = 38.6224
B1953p29 = 51.8224
J2010m1323 = 54.6045
J2017p0603 = 64.7805
J2043p1711 = 68.2016
J2145m0750 = 35.1591
J2214p3000 = 63.5145
J2302p4442 = 54.7043
J2317p1439 = 61.7739

pulsars = [J0023p0923, J0030p0451, J0340p4130, J0613m0200, J0645p5158, J0931m1902, J1012p5307, J1024m0719,
           J1455m3330, J1600m3053, J1614m2230, J1640p2224, J1643m1224, J1713p0747, J1738p0333, J1741p1351, J1744m1134,
           J1747m4036, J1853p1303, B1855p09, J1903p0327, J1909m3744, J1910p1256, J1918m0642, J1923p2515, B1937p21, J1944p0907,
           J1949p3106, B1953p29, J2010m1323, J2017p0603, J2043p1711, J2145m0750, J2214p3000, J2302p4442, J2317p1439]

puts 'Introduction: CP1919'
pulse_period = 1.33   # PSR 1919+21

with_fx :reverb do
  use_synth :chipnoise
  play choose(pulsars), attack: 3, release: 7, pan: rrand(-1,1), amp: 0.2
  sleep 3
end

vol = 0.1
9.times do
  sample :ambi_dark_woosh, rate: 1, amp: vol
  sleep pulse_period
  vol = vol + 0.1
end

pulse = in_thread do
  loop do
    sample :ambi_dark_woosh, rate: 1, amp: 0.3
    sleep pulse_period
  end
end

with_fx :reverb do
  use_synth :chipnoise
  play choose(pulsars), attack: 1, release: 3, pan: rrand(-1,1), amp: 0.2
  sleep 3
end

with_fx :reverb, room: 1 do
  sample :bd_boom, amp: 10, rate: 1
end

puts 'Part 1: Radio sky'

6.times do
  with_fx :reverb do
    use_synth :dpulse
    play choose(pulsars), attack: 0.5, release: 5, pan: rrand(-1,1), amp: 0.2
    sleep 5
  end
end

with_fx :reverb, room: 1 do
  sample :bd_boom, amp: 10, rate: 1
end

use_synth :growl
play choose(pulsars), release: 5

4.times do
  with_fx :reverb do
    use_synth :dpulse
    play choose(pulsars), attack: 0.5, release: 4, pan: rrand(-1,1), amp: rrand(0.2,0.7)
    sleep 4
  end
end

use_synth :pretty_bell
play choose(pulsars), release: 5

12.times do
  with_fx :reverb do
    use_synth :dpulse
    play choose(pulsars), attack: 0.5, release: 4, pan: rrand(-1,1), amp: rrand(0.2,0.7)
    sleep 2
  end
end

p = in_thread do
  use_synth :dpulse
  loop do
    with_fx :reverb do
      play choose(pulsars), attack: 0.5, release: 3, pan: rrand(-1,1), amp: rrand(0.5,1)
    end
    sleep 1
  end
end

sleep 2
use_synth :pretty_bell
play choose(pulsars), release: 5

b = in_thread do
  loop do
    with_fx :reverb, room: 1 do
      sample :bd_boom, amp: 10, rate: 1
    end
    sleep 8
  end
end

g = in_thread do
  loop do
    use_synth :growl
    play choose(pulsars), release: 5
    sleep 4
  end
end

sleep 60
p.kill

6.times do
  with_fx :reverb do
    use_synth :dpulse
    play choose(pulsars), attack: 0.5, release: 4, pan: rrand(-1,1), amp: rrand(0.2,0.7)
    sleep 2
  end
end

sleep 8

puts 'Part 2: Glitches'

60.times do
  with_fx :band_eq do
    use_synth :mod_sine
    play choose(pulsars), attack: 0.5, release: 1, pan: rrand(-1,1), amp: rrand(0.5,1)
    sleep 1
  end
end

30.times do
  with_fx :gverb do
    use_synth :mod_beep
    play choose(pulsars), attack: 0.5, release: 1, pan: rrand(-1,1), amp: rrand(0.5,1)
    sleep 1
  end
end

90.times do
  with_fx :gverb do
    use_synth :mod_tri
    play choose(pulsars), attack: 0.5, release: 1, pan: rrand(-1,1), amp: rrand(0.5,1)
    sleep 1
  end
end

20.times do
  with_fx :gverb do
    use_synth :mod_beep
    play choose(pulsars), attack: 0.5, release: 1, pan: rrand(-1,1), amp: rrand(0.5,1)
    sleep 1
  end
end

20.times do
  with_fx :band_eq do
    use_synth :mod_sine
    play choose(pulsars), attack: 0.5, release: 1, pan: rrand(-1,1), amp: rrand(0.5,1)
    sleep 1
  end
end

with_fx :reverb do
  use_synth :pretty_bell
  play choose(pulsars), release: 5, amp: 0.5
end

with_fx :reverb, room: 1 do
  sample :bd_boom, amp: 10, rate: 1
end

g.kill

sleep 8
with_fx :gverb do
  use_synth :pretty_bell
  play choose(pulsars), release: 5, amp: 0.5
  sleep 4
end

sleep 4
puts 'Part 3: Spindown'

6.times do
  with_fx :gverb do
    use_synth :blade
    play choose(pulsars), attack: 1, release: 4, pan: rrand(-1,1), amp: rrand(0.5,1)
    sleep 4
  end
end

use_synth :pretty_bell
play choose(pulsars), release: 5

24.times do
  with_fx :gverb do
    use_synth :blade
    play choose(pulsars), attack: 1, release: 2, pan: rrand(-1,1), amp: rrand(0.8,1.5)
    sleep 2
  end
end

24.times do
  with_fx :gverb do
    note = choose(pulsars)
    amplitude = rrand(0.8,1.5)
    use_synth :blade
    play note, attack: 1, release: 2, pan: rrand(-1,1), amp: amplitude
    use_synth :pretty_bell
    play note, attack: 1, release: 2, amp: amplitude
    sleep 2
  end
end

with_fx :reverb do
  use_synth :pretty_bell
  play choose(pulsars), release: 5, amp: 0.5
end

6.times do
  with_fx :gverb do
    use_synth :blade
    play choose(pulsars), attack: 1, release: 4, pan: rrand(-1,1), amp: rrand(0.5,1)
    sleep 4
  end
end

with_fx :gverb do
  use_synth :blade
  play choose(pulsars), attack: 2, release: 8, pan: rrand(-1,1), amp: rrand(0.5,1)
end

sleep 8
b.kill

2.times do
  with_fx :reverb do
    use_synth :dpulse
    play choose(pulsars), attack: 0.5, release: 4, pan: rrand(-1,1), amp: rrand(0.1,0.5)
    sleep 4
  end
end

with_fx :reverb, room: 1 do
  sample :bd_boom, amp: 10, rate: 1
end
sleep 2
with_fx :reverb do
  use_synth :pretty_bell
  play choose(pulsars), release: 6
end

2.times do
  with_fx :reverb do
    use_synth :dpulse
    play choose(pulsars), attack: 0.5, release: 4, pan: rrand(-1,1), amp: rrand(0.1,0.5)
    sleep 4
  end
end

2.times do
  with_fx :reverb do
    use_synth :dpulse
    play choose(pulsars), attack: 0.5, release: 6, pan: rrand(-1,1), amp: rrand(0.1,0.5)
    sleep 4
  end
end

with_fx :reverb, room: 1 do
  sample :bd_boom, amp: 10, rate: 1
end

with_fx :reverb do
  use_synth :dpulse
  play choose(pulsars), attack: 0.5, release: 6, pan: rrand(-1,1), amp: 0.2
  sleep 4
end

pulse.kill
vol = 0.3
6.times do
  sample :ambi_dark_woosh, rate: 1, amp: vol
  sleep pulse_period
  vol = vol - 0.05
end

