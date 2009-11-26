From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 26 Nov 2009 11:50:22 +0000
Subject: Re: [PATCH 1/2 v2] sh: mach-ecovec24: modify memory area
Message-Id: <20091126115022.GC6612@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u4ooho6yg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u4ooho6yg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 26, 2009 at 08:34:31PM +0900, Kuninori Morimoto wrote:
> This operation expect to jump to cached area, but "mova" command will
> get un-cached area in this case.
> This patch change it un-cached area to cached area
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Acked-by: Matt Fleming <matt@console-pimps.org>
