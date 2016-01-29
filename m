From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 29 Jan 2016 08:14:27 +0000
Subject: Re: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <20160129081427.GA2053@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
List-Id: <linux-sh.vger.kernel.org>
References: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-sh@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Having the clock patch applied on top of your renesas/v8-sdhi branch [1] I
> get
>=20
> root@salvator-x:/sys/kernel/debug/clk# cat clk_summary
>    clock             enable_cnt  prepare_cnt        rate
> --------------------------------------------------------
> ...
>     .main                     1            1     8333333
>     ...
>        .pll1                  1            1  1599999936
>           .pll1_div2          2            2   799999968
>              hdmi             0            0    24999999
>                 hdmi0         0            0    24999999
>                 hdmi1         0            0    24999999
>              cl               0            0    16666666
>              sd3              0            0    99999996
>                 sdif3         0            0    99999996
>              sd2              0            0    99999996
>                 sdif2         0            0    99999996
>              sd1              0            0    49999998
>                 sdif1         0            0    49999998
>              sd0              0            0    49999998
>                 sdif0         0            0    49999998

This is what I get (with your cleanup patch also applied):

=2E..
    .main                                 1            1     8333333       =
   0 0 =20
    ...
       .pll1                              1            1  1599999936       =
   0 0 =20
          .pll1_div2                      3            3   799999968       =
   0 0 =20
             hdmi                         0            0    24999999       =
   0 0 =20
                hdmi0                     0            0    24999999       =
   0 0 =20
                hdmi1                     0            0    24999999       =
   0 0 =20
             cl                           0            0    16666666       =
   0 0 =20
             sd3                          1            1   199999992       =
   0 0 =20
                sdif3                     1            2   199999992       =
   0 0 =20
             sd2                          0            0    49999998       =
   0 0 =20
                sdif2                     0            0    49999998       =
   0 0 =20
             sd1                          0            0    49999998       =
   0 0 =20
                sdif1                     0            0    49999998       =
   0 0 =20
             sd0                          1            1    49999998       =
   0 0 =20
                sdif0                     1            2    49999998       =
   0 0 =20

Could it be a firmware difference (i.e. bootloader trying to boot from eMMC=
 and
changing values)?

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWqx9iAAoJEBQN5MwUoCm20FwQAKQPLuwQQZo09phu9UIgNH6H
hiPPef4lB4+r7eVPAuzz2JBSHxwYxc1fllEDwx7SAydmXG2nqTI1tiWhweGgnTTz
reSrlCJxc+PE7Gx5gJQ1grIDZzT1SzDpEnbvYeZRBeZ2uQ4tnjQsg/eefIFbXz1f
B+vgYzO63686LEiQAx06LN7s4hf07E7mHhz9Gs57fM0594VAJD69jpaC36+lKJSx
uMdcVfdWOSF5Yia+ItyDX8SS6+zPiNu+kDp0YQGfv0LELSg0qQlWphs2E65qrxbK
YweOU8jndne9HKp5oaLq5G5WqsZ6Lc3+de58gu1+yFxxDMOWUfg1cDhwUVc1+rdf
nIiVVr5kNTPycSYj/FSfY9apFH6+eLXgbQCZ3TCRzBPCfoXcamHOiJAQY5XdWsjO
nVtWbXbuDuw6TS44vP/rkucZHo+nJ54FScsrBVU2tPWnwKwEaAmTF3JaHTp1Zl4L
heNuB7PDZfXMSjmYfs9GikPJiknTSY+MAbYH35ezjwinRnF+SYvtqM7D8B3oiT+/
JYyoOkKRpOp/jE5fpTLGKn5Qy1n4+ylnQnrgAfMOqHsk8KvQkaTvbiWOnWdFEoIa
S1EVzzgAlI05EAfBPwNNMY66eQY183q9HXWrAeQADQLnLaJQMHGmXQ+vq0qAnuK0
dTIWtRdbA37sdnNzYFhp
=Dgad
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
