From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 11 Dec 2013 15:35:36 +0000
Subject: Re: [PATCH 0/4] Fix backlight on Armadillo 800 EVA
Message-Id: <5234992.tYA5ejMsGh@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1435976.2aoNAcVxEV"
List-Id: <linux-sh.vger.kernel.org>
References: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--nextPart1435976.2aoNAcVxEV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Wednesday 11 December 2013 16:15:46 Thierry Reding wrote:
> On Wed, Dec 11, 2013 at 03:48:14AM +0100, Laurent Pinchart wrote:
> > Hello,
> > 
> > Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight: Add power
> > supply support") added a mandatory power supply for the PWM backlight,
> > resulting in broken backlight on the Armadillo board. This patch set fixes
> > the issue by adding power supplies to board code and DT, and adds proper
> > handling of the panel enable signal through the PWM backlight enable
> > GPIO.
> > 
> > Patch 1/4 fixes a v3.13 regression.
> 
> Actually there should be no regression at all here. The regulator core
> handles this case by providing a dummy if the property hasn't been
> specified in DT.

The regression fixed by 1/4 only affects the legacy (non-DT) Armadillo 800 EVA 
platform. In that case the regulator core doesn't provide a dummy regulator.

> > Strictly speaking patch 3/4 is as well, but the backlight was broken
> > anyway with DT due to the enable GPIO not being handled at all, so
> > there's no need to push it to v3.13.
> 
> If the backlight was broken anyway with DT, how could this new patch break
> it I wonder.

It obviously doesn't change the end result :-) I thought it introduced a new 
bug, but given that the regulator core provides a dummy regulator in this 
case, patch 3/4 is indeed not a regression fix.

-- 
Regards,

Laurent Pinchart

--nextPart1435976.2aoNAcVxEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqIZTAAoJEIkPb2GL7hl1mhEIAII7oGdg1ysKicrAw0z1blZJ
7hptvAvRpDWugZ5F4/Jnh2NkMazuOW6NM3Dv5h/VYiSyE7/CtFfOIqmUlNcaEPO8
9h452wAx/aKS4OcRAhFQFd2880reYeJz0KncPksP3rSFJz9k7MSev9RaCcVs13L8
WNmqF7TEothHfyQS6HhNq0IC4H97xAQ7hTibMjikmlPvedpMhgG3+DNvxgeL3QoS
fRBR7kgOgx0yGV29RD08vByTHg2xyox+fUSJFgiEZXGcqVE1nFHSO+zSosjSwUUA
wSeSaqi3H/enDXSNTyCSCJG5w49H03W4MQ79REvHXWHvXTbBLP6w9XrKrey7IRY=
=L8B4
-----END PGP SIGNATURE-----

--nextPart1435976.2aoNAcVxEV--

