From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Sep 2010 10:02:23 +0000
Subject: Re: [PATCH 2/2 v2] ARM: mach-shmobile: clock-sh7372: FSI parent
Message-Id: <AANLkTinV2acseNvs1+594hN1Fo2PanVPkebf6TM7H9Xj@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3piq1vsiif.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3piq1vsiif.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Sep 24, 2010 at 4:33 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* FSIACK is connected to AK4642,
>> > + =A0 =A0 =A0 =A0* and the rate is depend on playing sound rate.
>> > + =A0 =A0 =A0 =A0* So, set dummy rate (=3D 48k) here
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 ret =3D clk_set_rate(&sh7372_fsiack_clk, FSIACK_DUMMY_RA=
TE);
>> > + =A0 =A0 =A0 if (ret < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot set FSIACK dummy rate: %d=
\n", ret);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 fsia_ick =3D clk_get(&fsi_device.dev, "icka");
>> > + =A0 =A0 =A0 if (IS_ERR(fsia_ick)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(fsia_ick);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot get FSI ICK: %d\n", ret);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 ret =3D clk_set_parent(fsia_ick, &sh7372_fsiack_clk);
>> > + =A0 =A0 =A0 if (ret < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot set FSI-A parent: %d\n", =
ret);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 ret =3D clk_set_rate(fsia_ick, FSIACK_DUMMY_RATE);
>> > + =A0 =A0 =A0 if (ret < 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot set FSI-A rate: %d\n", re=
t);
>>
>> Is it really necessary to perform clk_set_rate() two times?
>
> Yes. both are needed.
>
> 1st dummy clk_set_rate is needed to ensure
> clk->rate of external pin (which is needed for 2nd clk_set_rate).
>
> 2nd clk_set_rate assure 1/1 clock divide for FSI-A.
> because default FSI-A division ratio is 1/64.

Ok, I understand and agree. I think your latest patch is ok.

Thanks for your help!

/ magnus
