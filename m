From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 10 Mar 2014 11:59:03 +0000
Subject: [RFC] Serial port aliases in DT
Message-Id: <5448979.WQPtOb56tW@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hello,

I've recently reviewed a patch adding serial port aliases to the device tree 
and would like to pick your brains about a disagreement I had with the 
developer.

The SoC includes 8 serial ports. They are all disabled in the SoC .dtsi, and 
enabled selectively by board DT files. As not all serial ports are available 
on all boards, the question was whether to add aliases for all ports (in the 
.dtsi in this case) like

         serial0 = &scif0;
         serial1 = &scif1;
         serial2 = &scif2;
         serial3 = &scif3;
         serial4 = &scif4;
         serial5 = &scif5;
         serial6 = &scif6;
         serial7 = &scif7;

or to just add aliases for the enabled ports (in the board DT file) like

         serial0 = &scif2;
         serial1 = &scif3;

Note the numbering in the latter case: as the board doesn't use serial ports 0 
and 1, hardware ports 2 and 3 become logical ports 0 and 1.

I considered that having Linux create ttySC0 and ttySC1 devices for the first 
two ports of the board, regardless of which hardware ports are used, is 
simpler from a user point of view (it allows sharing the same inittab settings 
for the console serial port across several boards for instance). I'd 
appreciate feedback on that.

-- 
Regards,

Laurent Pinchart

