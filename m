From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 30 May 2013 13:26:26 +0000
Subject: Re: [PATCH 05/11] ARM: shmobile: APE6EVM LAN9220 support
Message-Id: <201305301526.26225.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
 <CAOesGMjLiNTR7cqjSmyy2Ux1srgkC5cPO+D8UsRcgHbW8GQ26Q@mail.gmail.com>
 <Pine.LNX.4.64.1305300700150.24272@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305300700150.24272@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 30 May 2013, Guennadi Liakhovetski wrote:
> Ok, I didn't write the original implementation of that bus and, therefore, 
> didn't decide how many address cells it shall use. My task was to fix it. 
> And yes, I agree, that there are 2 ways to fix the memory mapping: either 
> define ranges to map from 64-bits to 32-bits, or to change all devices on 
> the bus (currently there's only 1) to use 64-bit "reg" property and use 
> "ranges" with no arguments. Since that bus is clearly within a 32-bit 
> area, I would prefer the former solution not to have to drag 64 bits 
> around an make device nodes simpler. Can we keep this approach or are you 
> strongly against it?

I believe we should attempt to have the DT representation as close as
possible to what the hardware actually does. If this is a AHB bus
or something else that is known to be always 32 bit, I would use
a ranges property and #address-cells=<1>, but if this is a 64-bit
wide AXIv4 instance I would use #address-cells=<2> and probably
omit the ranges.

There is also the case where a device is attached to an external bus
that has 0-based addressing. In that case I would put the actual
translation into the ranges property, with all addresses that
are translated by the bus controller, such as

      lbsc {
               compatible = "simple-bus";
               #address-cells = <1>;
               #size-cells = <1>;
               ranges = <0 0x08000000 0 0x1000000>; /* 16 MB @ 128 MB */

               ethernet@0 {
			compatible = "smsc,lan9118", "smsc,lan9115";
			reg = <0 0x1000>;
			...

	Arnd
