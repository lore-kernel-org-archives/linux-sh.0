From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 09 Jul 2013 17:24:07 +0000
Subject: emev2: clock driver dt proposal
Message-Id: <51DC4737.8020803@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To deal with peripheral clocks, I was working on the following idea
for a clock binding to deal with the gclk and sclks to each peripheral.

The parent control devices:

	sclk: clock-controller@e011600 {
	      compatible = "renesas,em-sclk";
	      reg = <0xe011600 0x100>;


	      #clock-cells = <2>;
	};

	This registers a clock-divider for the clock and a clock-mux to control the
	divder's parents.

	gclk: clock-controller@e011400 {
	      compatible = "renesas,em-gclk";
	      reg = <0xe011400 0x200>;
	      #clock-cells = <3>;
	}

	This driver provides the clock gates for both the bus clock and the sclk.


For each peripheral:

	shdci0 {
	       clocks = <&gclk 0xc8 0x5 0x2>, <&sclk 0x48 &pll3 &pll4 &osc0 
&osc1>;
	       clock-names = "bus", "sclk";
	}

	In this case, the gclk is in the form of:

	< &gclk register-offset-from-base bus-control-bitmask 
sclk-control-bitmask >

	And the sclk is in the form of:

	< &sclk register-offset-from-base
	  parent-clock-0 parent-clock-1 parent-clock-2 parent-clock-3 >



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
