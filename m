From: morimoto.kuninori@renesas.com
Date: Fri, 06 Mar 2009 05:13:04 +0000
Subject: Re: [PATCH v2] Add OHCI USB support for SH7786
Message-Id: <umybz9qu7.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Iwamatsu

Thank you for comment.

> If this setting is needed, it needs to be documented. While getting a set
> of register and value pairs from the hardware team is sufficient for
> device bring-up, we can not maintain or debug this if we have no idea
> what it is doing. Please confirm with the hardware team what this is
> necessary for, we especially need to be aware of whether this is an
> errata issue or not and whether this will continue to be necessary on
> future cuts.

OK. I will try to ask hardware team about it.
And then I will send v3 patch.

Best regards
--
Kuninori Morimoto
 
