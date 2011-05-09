From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 09 May 2011 03:51:15 +0000
Subject: arch_reset on AP4
Message-Id: <alpine.DEB.2.00.1105091235180.10149@localhost6.localdomain6>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

It seems that on the AP4EVB and mackerel boards, I am unable to properly 
issue a 'reboot' or 'shutdown' command from the command line.  The system 
will lock immediately after rebooting.
I looked into it a bit further and it seems that arch_reset() called in
  system.h makes a call to cpu_reset() that doesn't do anything but jump
to address 0.

Should this code be making use of the software reset offered in the 
SYSC register on the AP4? I threw together a quick patch and it seems to 
let me reboot sucessfully.  (See my next post: [PATCH] sh_mobile: Use 
SYSC.RESCNT2 to perform soft reboot).

I don't know if the register address and reset bit is common across all 
sh_mobile products though, so something more sophisticated might be 
needed.

Thanks,
Damian.
