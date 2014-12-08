From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 08 Dec 2014 18:11:16 +0000
Subject: Re: [PATCH v6 1/6] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <CAO3366xz4KJY=XM5jCJAvOQ7TEg+Vb6CqCZopp446Led6ZE4Qw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416500463-20965-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1416500463-20965-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 25, 2014 at 1:04 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 20 November 2014 17:20:58 Ulrich Hecht wrote:
[...]
>> +                                     mult *= 2;
>> +             }
>> +     } else if (!strcmp(name, "dsi0phy") || !strcmp(name, "dsi1phy")) {
>> +             u32 phy_no = name[3] - '0';
>> +             void __iomem *dsi_reg = cpg->reg +
>> +                     (phy_no ? CPG_DSI1PHYCR : CPG_DSI0PHYCR);
>> +
>> +             parent_name = phy_no ? "dsi1pck" : "dsi0pck";
>> +             div = __raw_readl(dsi_reg);
>> +             if (!(div & 0xb8000))
>
> If I'm not mistaken the PLL is disabled if the MANUAL bit is set and the BYPSL
> is clear. The above check would consider the PLL to be enabled.

That is a translation of the corresponding part of the legacy driver,
where it is appropriately labeled "/* FIXME */"...

I think it is sufficient to examine PLLE here.  We don't really care
why the PLL is on or off at this point.

More embarrassing is the fact that that should be "mult" up there...
(This error also exists in the legacy driver.)

CU
Uli
