From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Feb 2016 21:13:08 +0000
Subject: Re: Programmable clock in salvator-x
Message-Id: <4603120.DhCuQePTxB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <CAJ--JmwGfEg+UES_ivs5avsoyaYPQoJf+ZKu1spOE-J1LAhaEQ@mail.gmail.com>
In-Reply-To: <CAJ--JmwGfEg+UES_ivs5avsoyaYPQoJf+ZKu1spOE-J1LAhaEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Hamza,

On Tuesday 09 February 2016 10:47:39 Hamza Farooq wrote:
> Hi,
> 
> in order to use IDT 5P49V5923A programmable clock for DU, I was
> wondering if the driver for it is already available/present in the
> Linux source tree. It seems to be present on the board but not
> used/enabled from salvator-x device tree.
> 
> programable_clk0 and programable_clk01 seem to be used in du node but
> not associated with IDT clock chip. Or am I overlooking something?

All clock drivers are available in drivers/clk/. Quickly looking through that 
direction I don't see a driver specifically for the 5P49V5923A. If the chip is 
pin-to-pin compatible with another component from a different vendor you might 
be to reuse one of the existing drivers, otherwise you will need to develop a 
new one.

-- 
Regards,

Laurent Pinchart

