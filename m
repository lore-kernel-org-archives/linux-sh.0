From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 05 Dec 2013 00:47:04 +0000
Subject: Re: [PATCH 1/2] regulator: gpio-regulator: Add required regulator-type property
Message-Id: <2248657.5UVkYxaC6z@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5628607.Ntb9itnPrM"
List-Id: <linux-sh.vger.kernel.org>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385653493-9952-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131205000928.GI29268@sirena.org.uk>
In-Reply-To: <20131205000928.GI29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--nextPart5628607.Ntb9itnPrM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mark,

On Thursday 05 December 2013 00:09:28 Mark Brown wrote:
> On Thu, Nov 28, 2013 at 04:44:52PM +0100, Laurent Pinchart wrote:
> > The gpio-regulator driver requires the regulator-type property to be
> > present. Document it as required in the DT bindings.
> 
> It does?  That seems needless.  It should just default to voltage and
> provide a way override to current, though frankly I'd be astonished to see a
> GPIO controlled current regulator at all so I'm not sure I'd even bother
> writing the code for that until someone needs it.  As it is this will most
> likely just be noise in the DT files and wasted cycles parsing the property.

I'm fine with that. The property should still be documented in the DT bindings 
as optional though. Or be removed completely until a GPIO-controlled current 
regulator is needed.

> Please CC maintainers...

My bad, sorry.

-- 
Regards,

Laurent Pinchart

--nextPart5628607.Ntb9itnPrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSn80NAAoJEIkPb2GL7hl1uOAH/R+F5mOMmhFCASa2iP/IPvl1
UXzxpL8ibAMN2RL+aNuQBl32J/KW/DFbqZ0FnrrushaseU5lAiBZS1XXklkt59Vz
z0Bsg4icgIAa/qn7N7uX3h3lijtcBWL9pS8SXasFbUMuTpLUQmpstPEH5KI6QAgm
6XWPFUzfQXQEt2qvZ5ZZNv4I8kityV+sQjB4WqUPi5WjyU65HKP+ss+TF9Ej42yX
L7nVJHixmq+CWd6RNovbcbrBBnSo+arzEn3GDTTqa8QQ9eXo5X2vqObUVsUBjPhb
+L7tzhUOnHl+PrBMZywVieS5RCYdMgrubDVny8tSiSWNU3skOAkP3lydmZKc8I4=
=evu0
-----END PGP SIGNATURE-----

--nextPart5628607.Ntb9itnPrM--

