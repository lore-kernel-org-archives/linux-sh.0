From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 27 Nov 2013 11:04:13 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
Message-Id: <20131127110413.GA2603@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
List-Id: <linux-sh.vger.kernel.org>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127082805.20015.82680.sendpatchset@w520>
In-Reply-To: <20131127082805.20015.82680.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eeprom: 24c128@50 {
> +			compatible = "at,24c128";

Minor nit: Should be a vendor name, not the name of the driver

> +			reg = <0x50>;
> +		};
> +	};
> +
>  };

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSldGtAAoJEBQN5MwUoCm2f/8QAJZWYR5hvw08RKIrzEt/atIR
DoW9k3O485XOP+SOT0Vq/B2+Gf0X7x/JvSjd4gqiSqyV2Cu/QD7po9dP8ULHj1iG
aKz1D3Vo4SwqsnY/+eSP5Fehe1igqlDLC6nbJocP7EgxGtyl7QzZBdqaiH2Y0Kg0
OA/bC1P/gdXCDdVZAflGue1A1A4D5j5xWSe0LLtM2AB8EIirnsbwL7U19RrkmYqW
lczqNTnJRqx35MkGr5xuT6gBAgNLbBooJUtGiwzdxW3iNTKjZyyvnrBnryLsxN9N
6mKX6Jpf8WgSf8dotbsnbUUv/Ku7G9mxlRTMU+55BcxWxmnWWKbFPIGxolVr/RWe
4w25ci/8yTVKyDZlqDz10sYfur/meQ/b1u3/RbXXikPhgpRMJph2horfxrOCQNfk
PS2nYtKLXBOkWMADOZWevTdBUEppgeibpYiRrX+/8JPVkKWBV44oJYLlnvg9rD+B
t1kbdrmL35U6d6ksK4fUb5GxdE/e0i+8nHcsMZ9YeIczVgWJPbH8JsSk+Uz5T3sM
G5NEZwUV8uHZpDTPNZvXMIhWC9MqRj2hc5OLkA7HGxF75BzvFJ/fwUPTtgOCZn+p
5CKR2YrIPrEuLMjL6/xMnjYg5fFlZM2wYevOYKMRRUr0P+V4x9agEh/wq9NSBO39
3b2ts1Wde0fYnJAd+0HA
=LZVQ
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
