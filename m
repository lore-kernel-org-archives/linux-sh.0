From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 06 Oct 2014 09:01:50 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: Add early debugging support using SCIF(A)
Message-Id: <20141006090149.GC1266@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GPJrCs/72TxItFYR"
List-Id: <linux-sh.vger.kernel.org>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon> <20141006060347.GB1266@katana>
 <CAMuHMdXRcuq+hcyjeRDgFqKo2n7JSR5tTfz6wstTXnm2ohKdtQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXRcuq+hcyjeRDgFqKo2n7JSR5tTfz6wstTXnm2ohKdtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I agree with your statement about using the same wires.
> However, having the ability to pinmux both SCIF0 and SCIFA0 to the same
> wires is not a board property, but an SoC property, right?

Both. The SoC needs to support muxing them to the same wires, yes. But
the board must also support it. E.g. SCIFA0 could already be used using
some other wires, then it is not possible anymore.

> Nevertheless, for DEBUG_LL, this is early debug output, so it should use the
> exact same settings as the bootloader, which has configured SCIF0, and
> (b) has setup pinmux for SCIF0.

True.


--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMlp9AAoJEBQN5MwUoCm2FFQP/2uX5L3ndoBflaBrXOA9Hu7n
VnmnkbE+gzSVbGBA40B7ZqR6jDZ1RyqeNGcu2gy+wIqy5oNpNogsuk4/CVi3iv3f
vlYQWrcsF7nFEOnt3XnBRH0VlK51sT/Y7SzAwxzNyNWW7OZVDbA0cLxkqJqwvvf2
rWeTctoJF+MKUwJbNIlsvbN23l7obYlxK6iNkzzIg3/yIUApUmnVG0EgsBk+ut+p
6IS76c6d3n0Wwmta4rZuThJYaydwC6FHIS0/PXIEocrbRdYtXqU1dUFy5lxVuUif
GdOB3OdzvXJ+9HFDoxb2rWMNFwH75v8Mp5UlE0lupgnWWwA2I0C4aT4qtPaxUxjI
eJMLgu5yxwLO90khoSPgdNNBxRsYT+HUSOGKbr/22IiYDD/otxugw6husdvLr/OH
cFMMCHPHJ3FbdifVEvwyf0C7j8jxyYUjf2Hz4BOxMe+p6ghMi6vJw34LfN7/W3N9
DZkEujHAKa44+Sjq/9ggGChNM2dA6qixWJwei0qdX/JSo9+/1IVG/Ht4xW0nC62r
eHgSVKHRm1Vqa5H0mbVMRe4GiU86ltrkH/OBx1abSJN6LWAEtUP2I0iwwRLleL9o
WtWBZJzGV0iVi98/lYinhrc+pNBfYsHnav5nTxzsDEHq/MHYnDstSRF7MRYooS+B
yLa4dORhePdLBZWx5h9V
=u7Qn
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
