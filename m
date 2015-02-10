From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Feb 2015 18:49:18 +0000
Subject: Re: [PATCH v2 14/15] ARM: shmobile: bockw dts: Move Ethernet node to BSC
Message-Id: <2138824.q8uNlgd31t@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-15-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-15-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Tuesday 10 February 2015 12:14:14 Geert Uytterhoeven wrote:
> On Mon, Feb 9, 2015 at 5:02 PM, Ulrich Hecht
> 
> <ulrich.hecht+renesas@gmail.com> wrote:
> > +&bsc {
> > +       ethernet@18300000 {
> > +               compatible = "smsc,lan9220", "smsc,lan9115",
> > "smsc,lan89218";
>
> The most specific (89218) compatible name should be listed first.
> I think the 9220 entry is not required, so I'd use just
> 
>         compatible = "smsc,lan89218", "smsc,lan9115"

The 9220 entry isn't required by the Linux driver as it detects the chip 
version at runtime. It could be useful for other operating systems (assuming, 
of course, that the 89218 implements features found in the 9220 but not in the 
9115), but I don't think we need to care too much about that as this is a .dts 
part of the Linux kernel sources and not a binding specification.

-- 
Regards,

Laurent Pinchart

