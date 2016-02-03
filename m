From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 03 Feb 2016 04:10:20 +0000
Subject: Re: [LTSI-dev] THERMAL:Incorrect measured temperature value after unbind/bind
Message-Id: <20160203041020.GA22555@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Feb 03, 2016 at 09:55:09AM +0900, Nguyen Viet Dung wrote:
> Hi,
>=20
> when testting LTSI-v4.1.13-rc1 on the SOC of RENESAS(Lager board, Koelsch
> board),
> we have found the following the failure about the rcar_thermal driver.
> Detail of this failure is:
> [After unbind/rebind rcar_thermal measured temperature is not
> correct(-65.0=B0C)]
> error log:
>  Koelsch_Thermal_unbind_rebind_error_log.txt
>  Lager_Thermal_unbind_rebind_error_log.txt
>=20
> We have checked that this failure had fixed by one Patch of Linux-Next
> branch.
> (5de85b9d57aba3ed2e04759e6db3b9e826dd0b06
> "PM / runtime: Re-init runtime PM states at probe error and driver unbind=
")
>=20
> Please consider this patch to fix error for next LTSI release

I'm a bit worried that something like this isn't in the stable
kernel releases, shouldn't it also go there as well?

thanks,

greg k-h
