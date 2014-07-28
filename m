From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Jul 2014 13:48:04 +0000
Subject: Re: [PATCH 01/12] ASoC: rsnd: fixup rsnd_gen_dma_addr() for Gen1
Message-Id: <20140728134804.GW17528@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7TOlKqtLs8Nv5Cm2"
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
 <87bntqzjfw.wl%kuninori.morimoto.gx@renesas.com>
 <20140618100654.GF5099@sirena.org.uk>
 <20140728125840.GA10125@verge.net.au>
In-Reply-To: <20140728125840.GA10125@verge.net.au>
To: Simon Horman <horms@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-sh@vger.kernel.org


--7TOlKqtLs8Nv5Cm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 09:58:43PM +0900, Simon Horman wrote:
> On Wed, Jun 18, 2014 at 11:06:54AM +0100, Mark Brown wrote:

> > > ad32d0c7b0e993433df152ae747652647eb65a27
> > > (ASoC: rsnd: add rsnd_gen_dma_addr() for DMAC addr)
> > > added rsnd_gen_dma_addr() to calculate DMA addr,

> > Applied, thanks.

> I guess its a little too late in the cycle and I apologise
> for not having noticed this earlier. It seems that while
> this problem was added in v3.16-rc1 (by the patch detailed above)
> the fix (this patch) is not present in v3.16-rc7.

Yeah, I've got too big a backlog of fixes to actually send to Linus at
this point.

--7TOlKqtLs8Nv5Cm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1lSRAAoJELSic+t+oim9QPwQAINaQN7HeOnJ4EhOMycFaQ/E
OEXFlDHpxp3X0RM0Ew7Q4evx2BD9X9CXqQs409w5aaL5fr6e+2sUCK7UDq4tAi3n
c6n4uzRedDByEk3lXc9hdZ0X78qAWO79u1U4Tyltgjs71AyDGUvT0xGOYKwOAf2j
kKF8MDFV9WTAEQO8OUclc+kg2Lnpba8kbW0aGnNEWtu/GzIR6AFLFEJHadyJ7ASk
0hcUWfDxQtqAI4vukAVdGSoytqh3fIUrg+QxBWWgSPo+i/ZkUM6tmK6r5fEAw2Xa
QZ4IfN9qd9dlRS9OjJcQMexAy7F+ioSHxYBqK4iKLI9Z3qrhnqV94lovDX+yO9hh
j5oMCEcpcGXjytmPGZdR8D382lWx5/JjMFXFRKNvhmbNOZGU2goc8zrucAW5tNHM
hKbpzox7tPkaTwVgJqXj/OLP4t55S1WQaMFVeGHffDxgNFtU4ho9B5j4oo98ecyo
wDV73UHhHXcUJ8jenspA16XN/QYgN3mzh/Tc6W9HMMp9xFaOZoOw97KS0er3+NrI
1Bp96BODPg1vXfpbDofJON/No46AG8TmxgDklt/TMRSNUfJjGrnCEYEeT9V6Cp1x
cruh0swzjWjj9JDfaeH3SeOV4cinvJJFsA3tA9rhOYZZ8v35p1ExRzl/gadOrhkf
VPVn3rQhvVEpkbDeMiUC
=PUW1
-----END PGP SIGNATURE-----

--7TOlKqtLs8Nv5Cm2--
