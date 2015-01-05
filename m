From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 05 Jan 2015 08:27:50 +0000
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Message-Id: <9953341.ly5Z8mnrNK@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdXcfe0JQhZzGSAoqjKR346-QJrvyi=afHF7cAaHKa56pw@mail.gmail.com> <10011053.aypz0IuTJG@avalon>
In-Reply-To: <10011053.aypz0IuTJG@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Geert,

On Thursday 18 December 2014 21:23:46 Laurent Pinchart wrote:
> On Thursday 18 December 2014 14:03:18 Geert Uytterhoeven wrote:
> > On Thu, Dec 18, 2014 at 1:49 PM, Laurent Pinchart wrote:
> > > There are three compatible strings defined for the ADXL345 and ADXL346
> > > in Documentation/devicetree/bindings/i2c/trivial-devices.txt:
> > > "adi,adxl345", "adi,adxl346", "adi,adxl34x". Given that the last one is
> > > a fallback for the first two I don't see a need to add the specific
> > > compatible strings to the driver for now. If a new totally incompatible
> > > chip named ADXL347 comes out we will need a new driver which won't be
> > > allowed to use the "adi,adxl34x" compatible string.
> > 
> > FWIW, I'm the evil person who added the adxl entries to that file...
> 
> git-blame had already reported you.
> 
> Do you think we should remove that compatible string ?

Ping ?

-- 
Regards,

Laurent Pinchart

