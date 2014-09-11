From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 11 Sep 2014 00:11:45 +0000
Subject: Re: [PATCH 0/4] usb: renesas_usbhs: fixes this driver in gadget mode (part2)
Message-Id: <5410E8C1.70500@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53F725E3.4050304@renesas.com>
In-Reply-To: <53F725E3.4050304@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Felipe,

(2014/09/10 22:49), Felipe Balbi wrote:
> On Wed, Sep 10, 2014 at 07:33:27PM +0900, Yoshihiro Shimoda wrote:
>> If we tested this driver as gadget, some issues below happened:
>>  - Oops happened if g_audio.
>>  - A usb enumeration may fail if we do insmod during connected the usb cable.
>>  - A transaction will not finish if g_zero.
>>  - A usb enumeration may fail after we re-connected the usb cable.
>>
>> This patch serias fixes them.
>> This patch serias is based on Felipe's usb.git, testing/fixes branch.
>> (commit id: 0b93a4c838fa10370d72f86fe712426ac63804de)
> 
> Can you start sending your patches as a thread ? It makes it easier to
> find them. If you're already formatting patches to a directory, then all
> you have to git send-email the difectory, instead of all files in that.
> 
> e.g.:
> 
> 	$ git format-patch -o patches --cover-letter -4
> 	$ vim patches/0000-cover-letter*
> 	$ git send-email --to balbi@ti.com --cc linux-usb@vger.kernel.org \
> 		patches

Thank you for the comment. Yes, I will try this command from next time.

> With that said, do we need these patches in v3.17 final ? or only v3.18?
> It's getting pretty late for v3.17-final...

I understand it's getting pretty late for v3.17-final.
So, I will send these patches for v3.18.

Best regards,
Yoshihiro Shimoda
