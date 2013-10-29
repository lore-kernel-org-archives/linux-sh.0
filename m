From: Sebastian Reichel <sre@ring0.de>
Date: Tue, 29 Oct 2013 23:28:39 +0000
Subject: Re: [PATCH v7 1/5] omap3isp: Modify clocks registration to avoid circular references
Message-Id: <20131029232837.GB2266@earth.universe>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EuxKj2iCbKjpUGkD"
List-Id: <linux-sh.vger.kernel.org>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <1383076268-8984-2-git-send-email-s.nawrocki@samsung.com>
 <16467881.81yEf9zq68@avalon>
In-Reply-To: <16467881.81yEf9zq68@avalon>
To: linux-arm-kernel@lists.infradead.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 29, 2013 at 11:28:37PM +0100, Laurent Pinchart wrote:
> On Tuesday 29 October 2013 20:51:04 Sylwester Nawrocki wrote:
> > The clock core code is going to be modified so clk_get() takes
> > reference on the clock provider module. Until the potential circular
> > reference issue is properly addressed, we pass NULL as as the first
> > argument to clk_register(), in order to disallow sub-devices taking
> > a reference on the ISP module back trough clk_get(). This should
> > prevent locking the modules in memory.
> >=20
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>=20
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> Do you plan to push this to mainline as part of this patch series ? I don=
't=20
> have pending patches for the omap3isp that would conflict with this patch=
, so=20
> that would be fine with me.

I plan to add support for DT to omap3isp + ADP1653 shortly. I have
not yet started to work on this, but expect to send some first RFC
patches in November.

-- Sebastian

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJScESlAAoJENju1/PIO/qaty0P/ikY5V2SD3vIeSJREZ22QUFL
UEcNERqLfy2bFF3M2yF5hYxTlW8K3iappltDlalaKypHo8GHLZdh7ZOYx4SEet0C
aFJo7JIYC42hTTzfdU+v6b5+5x9eECq0+titlLSzXBcKco/390ETcLRgTJAIjprX
ex8/BYvp4bLxYrVnvyWaCSXPG0OGIIuBBWSRfzhhOGIjJ2oSD8C7F9jSPKoOPV7z
PsU95Z8xdapg+9QzXf3wAGbdZ+YldHoFCEfDnz3CDTpbzt+nD0wdYhB1EAZH/Skn
8XnK04scyGqijlZZKUi7PApb3f0NB72iX/Kq79OSkrxB3TaS4US8gQP7TzkDVm74
fONnHkiE3irwgbX9dM9T9WWcO7BXYHPtP646YtrFHWevokI/lbwDZgXbj56A0LMH
t8/Qyqa/zY1lYfInBHg3y6f5tK4EgZoy6KqLcVDDD+MDSwoc3Qqg7CqQExN3pDlP
6HY/K8VagMqVmqQDU6JQ1PHAjgKY1qepjO6rceS8a2slcfQTyx3h5JCb8CmkNTh+
er94DO/AgRibTxCJfyQkz1x7eodEbDcApJKKl1SYWQjcl2syg4YfTtPAz0WpYlcd
YCWnXHmJnv9/NQDOg+EWbJrMn+zLrKfN7CbVD6cEd+LdYze2r+9qKI3TZyUJlxq2
97SygysEp7jr1vWclZXT
=BbXO
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
