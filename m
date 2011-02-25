From: Greg KH <greg@kroah.com>
Date: Fri, 25 Feb 2011 19:39:33 +0000
Subject: Re: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <20110225193933.GB3702@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Feb 25, 2011 at 01:26:18PM +0900, Yoshihiro Shimoda wrote:
> Hi Paul,
>=20
> 2011/02/25 12:19, Paul Mundt wrote:
> > On Thu, Feb 24, 2011 at 06:47:10PM +0900, Yoshihiro Shimoda wrote:
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> ---
> >>  about v2:
> >>   - fix the condition for other CPU in ehci-hcd.c.
> >>
> > And how exactly are you enabling this when the 7757 Kconfig entry doesn=
't
> > select either of USB_ARCH_HAS_OHCI or USB_ARCH_HAS_EHCI?
> >=20
> I intended to submit a patch which modified Kconfig after this patch appl=
ied.
> But I should also have submitted the patch together.
> I will submit it and other necessary patches=E3=80=80to linux-sh ml.

Ok, then I will drop this one from my queue.

For such simple config patches, they can go through the sh tree, no need
to go through the usb one.

thanks,

greg k-h
