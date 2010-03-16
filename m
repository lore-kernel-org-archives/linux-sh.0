From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Tue, 16 Mar 2010 09:07:07 +0000
Subject: AW: r8a66597-hcd panics when a USB device is removed from an
Message-Id: <95F51F4B902CAC40AF459205F6322F017F26D4B540@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F017F26D4B469@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F017F26D4B469@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello Mr. Yoshihiro

patch works, many thanks.

Mit freundlichen Gr=FC=DFen / Best Regards

Markus Pietrek
Software engineer

--
emtrion GmbH
Greschbachstr. 12
76229 Karlsruhe
GERMANY

Phone  +49 721 62725-45
Fax    +49 721 62725-19
E-mail Markus.Pietrek@emtrion.de
http://www.emtrion.de



> -----Urspr=FCngliche Nachricht-----
> Von: shimoda.yoshihiro@renesas.com
> [mailto:shimoda.yoshihiro@renesas.com]
> Gesendet: Dienstag, 16. M=E4rz 2010 04:30
> An: Paul Mundt; Pietrek, Markus
> Cc: Alan Stern; linux-sh@vger.kernel.org; USB list
> Betreff: Re: r8a66597-hcd panics when a USB device is removed from an
> attached hub
>
> Paul Mundt wrote:
> > On Mon, Mar 15, 2010 at 10:00:07AM -0400, Alan Stern wrote:
> >> Is there some reason why you guys haven't tried asking the author of
> >> r8a66597-hcd (CC'ed)?  He's in a better position than anyone else to
> >> fix the problem.
> >>
> > He's on the list as well, just unresponsive as of late, which is why
> I
> > waited some time before replying and adding linux-usb to the Cc.
> >
> I'm sorry for my lazy response.
> I check this issue, and I fixed it.
>
>
> Hello Mr. Markus,
>
> Thank you for your detail report!
> I made a patch. If possible, would you test it on your environment?
>
> Thanks,
> Yoshihiro Shimoda
> ---
>
> Subject: [PATCH] usb: r8a66597-hcd: fix removed from an attached hub
>
> fix the problem that when a USB hub is attached to the r8a66597-hcd and
> a device is removed from that hub, it's likely that a kernel panic
> follows.
>
> Reported-by: Markus Pietrek <Markus.Pietrek@emtrion.de>
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
>  drivers/usb/host/r8a66597-hcd.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/r8a66597-hcd.c
> b/drivers/usb/host/r8a66597-hcd.c
> index bee558a..f71a73a 100644
> --- a/drivers/usb/host/r8a66597-hcd.c
> +++ b/drivers/usb/host/r8a66597-hcd.c
> @@ -418,7 +418,7 @@ static u8 alloc_usb_address(struct r8a66597
> *r8a66597, struct urb *urb)
>
>  /* this function must be called with interrupt disabled */
>  static void free_usb_address(struct r8a66597 *r8a66597,
> -                          struct r8a66597_device *dev)
> +                          struct r8a66597_device *dev, int reset)
>  {
>       int port;
>
> @@ -430,7 +430,13 @@ static void free_usb_address(struct r8a66597
> *r8a66597,
>       dev->state =3D USB_STATE_DEFAULT;
>       r8a66597->address_map &=3D ~(1 << dev->address);
>       dev->address =3D 0;
> -     dev_set_drvdata(&dev->udev->dev, NULL);
> +     /*
> +      * Only when resetting USB, it is necessary to erase drvdata.
> When
> +      * a usb device with usb hub is disconnect, "dev->udev" is
> already
> +      * freed on usb_desconnect(). So we cannot access the data.
> +      */
> +     if (reset)
> +             dev_set_drvdata(&dev->udev->dev, NULL);
>       list_del(&dev->device_list);
>       kfree(dev);
>
> @@ -1069,7 +1075,7 @@ static void r8a66597_usb_disconnect(struct
> r8a66597 *r8a66597, int port)
>       struct r8a66597_device *dev =3D r8a66597->root_hub[port].dev;
>
>       disable_r8a66597_pipe_all(r8a66597, dev);
> -     free_usb_address(r8a66597, dev);
> +     free_usb_address(r8a66597, dev, 0);
>
>       start_root_hub_sampling(r8a66597, port, 0);
>  }
> @@ -2085,7 +2091,7 @@ static void update_usb_address_map(struct
> r8a66597 *r8a66597,
>                               spin_lock_irqsave(&r8a66597->lock, flags);
>                               dev =3D get_r8a66597_device(r8a66597, addr);
>                               disable_r8a66597_pipe_all(r8a66597, dev);
> -                             free_usb_address(r8a66597, dev);
> +                             free_usb_address(r8a66597, dev, 0);
>                               put_child_connect_map(r8a66597, addr);
>                               spin_unlock_irqrestore(&r8a66597->lock, fla=
gs);
>                       }
> @@ -2228,7 +2234,7 @@ static int r8a66597_hub_control(struct usb_hcd
> *hcd, u16 typeReq, u16 wValue,
>                       rh->port |=3D (1 << USB_PORT_FEAT_RESET);
>
>                       disable_r8a66597_pipe_all(r8a66597, dev);
> -                     free_usb_address(r8a66597, dev);
> +                     free_usb_address(r8a66597, dev, 1);
>
>                       r8a66597_mdfy(r8a66597, USBRST, USBRST | UACT,
>                                     get_dvstctr_reg(port));
> --
> 1.5.5


_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or other=
wise confidential information.
- If you have received this e-mail in error, you are hereby notified that a=
ny review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
