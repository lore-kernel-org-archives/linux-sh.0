From: Federico Fuga <ml@studiofuga.com>
Date: Mon, 10 Oct 2011 13:21:08 +0000
Subject: Re: [SpamAssassin] [PATCH/RFC] sh: Use big endian ioread/write for SH2A platforms
Message-Id: <13232B37-913A-457A-9DE8-6723570A2EAB@studiofuga.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Il giorno 03/ott/2011, alle ore 16.16, Phil Edworthy ha scritto:

> Commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba makes all ioread/iowrite
> functions treat registers as little endian. For SH2A this is not the case,
> they are big endian.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>



This makes my system (based on sh7203) bootable again.
Thanks


Tested-by: Federico Fuga <fuga@studiofuga.com>


