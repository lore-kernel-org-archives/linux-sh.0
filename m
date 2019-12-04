From: Karl Nasrallah <knnspeed@aol.com>
Date: Wed, 04 Dec 2019 06:07:06 +0000
Subject: Strange SH7750/SH7750S-Style Performance Counters Behavior
Message-Id: <1686953279.8556109.1575439626669@mail.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Apologies if this is not the right place for this, but I have encountered some strange behavior with the SH7750-style performance counters that I have been trying to understand for nearly two weeks to no avail.

Essentially, I wrote a set of functions to control the counters in a way analogous to the SH4 linux kernel's perf_event.c, as that file is the only real documentation I could find on them. As far as I can tell, it all works, however every time I read the counters I get a value that according to my calculations is about 11.96988 times too fast.

I am using elapsed time mode (event code 0x23) and the exact CPU model I am running this on is an SH7091, which were used by SEGA in the early 2000s in their Dreamcast and NAOMI machines. As far as I can tell, they are largely identical to the SH7750/SH7750S processors. The maximum internal core/PLL frequency is 200MHz, so seeing the counters run at 12x PLL is extremely odd. I have two machines as well, and they both exhibit this behavior, although for some unknown reason every now and again one of them will turn on and count 200MHz core frequency cycles instead of 11.96988 x 200MHz core frequency cycles.

I have also measured that this 11.96988 number is actually extremely consistent to at least 3-4 decimal places; it is never 12 or 11.90.

Is there any chance that someone here has seen this behavior before?
Also, might anyone know what the definition PMCR_CLKF 0x100 in perf_event.c does? I have not seen this actually used anywhere.

Any insight would be very greatly appreciated!
