From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 02 May 2012 09:47:21 +0000
Subject: Re: [PATCH v2 09/10] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <CABYn4swN7PrGPVx2+FPkYx+g6Y=0v9e86KXVx2UVxDwhOaZPCg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
 <1335362618-4559-10-git-send-email-hechtb@gmail.com>
 <CAN8TOE9fnQJb6ivwg997cE93g+PcxvvgZzGHsm2Ua6o_ZzH=HQ@mail.gmail.com>
In-Reply-To: <CAN8TOE9fnQJb6ivwg997cE93g+PcxvvgZzGHsm2Ua6o_ZzH=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Norris <computersforpeace@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

Hi Brian,

> I don't know about the HW-specific details here, but read/write
> data+OOB seems good.
>
> Acked-by: Brian Norris <computersforpeace@gmail.com>
>
> If these patches are accepted, I will try to make sure this driver
> switches to conditionally reading/writing OOB in my patch series. Keep
> an eye out for them, though.

Thanks! I've submitted a new version of my patchset and they don't
stack out of the box with your patch-set - either way if yours comes
first or mine, it should require little to adapt.

> BTW, from the changes I'm seeing in this patch series, your driver was
> previously fairly broken. Or at least, several features of it were...
> Good luck with the cleanup!

Yeah thanks! I like the driver and learned a lot from it - but the ECC
part was broken like hell, true :)

Best regards,

 Bastian

> Brian
