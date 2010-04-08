From: "Andrew Murray" <amurray@mpc-data.co.uk>
Date: Thu, 08 Apr 2010 13:40:48 +0000
Subject: SDK7786 zImage difficulities
Message-Id: <0C997DD87CC88A4F86C897F52650B52B0299816A@MOLSON.mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I've been unable to successfully use a zImage when using the defconfig
for the SDK7786 (head ...2fe3fe Apr 7).

When loading the zImage though a debugger to 0x60000000 and executing
from 0x60000000 (after allowing the ETS firmware to run to prompt) the
decompressor head relocates itself and jumps to 0x80800058 - however I
thought this was somewhere in the PCI space. This then results in a
general instruction exception which seems to be handled by the ETS:

**** Unhandled interrupt! - Exception registers: ****
TRAPA : 0x0
EXPEVT: 0x180
INTEVT: 0x420

Has anyone successfully used a zImage on this board - or could it be
broken in some way? I'm nearing my depth here so will be more than happy
for assistance.

Thanks,

Andrew Murray
