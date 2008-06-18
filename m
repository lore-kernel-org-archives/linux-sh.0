From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 18 Jun 2008 08:57:21 +0000
Subject: Re: sh/boards/se/770x/io.c: suspicious code
Message-Id: <4858CDF1.3070804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080615221606.GA1407@cs181133002.pp.htv.fi>
In-Reply-To: <20080615221606.GA1407@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Adrian.

Adrian Bunk wrote:
> sh_pcic_io_start and sh_pcic_io_stop are used as lower and upper limits 
> for ports but never set to any non-zero value.

This code is used from linux-2.4 very old.
Mrshpc_ss.c(pcmcia socket driver) used sh_pcic_io_start in linux-2.4.
This driver doesn't exist now. The place where you are pointing it out
might already be unnecessary. I will send the patch to clean it.

Best regards,
  Nobuhiro





