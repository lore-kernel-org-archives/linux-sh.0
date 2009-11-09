From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Nov 2009 03:03:54 +0000
Subject: Re: [PATCH] uio: pm_runtime_disable is needed if failed
Message-Id: <aec7e5c30911081903g377c82fewa6606dd80bbcbd0c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ufx8oju54.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ufx8oju54.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 9, 2009 at 11:42 AM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>>> Magnus
>
> Please check this patch.
> I think pm_runtime_disable is needed here.

Looks correct!

/ magnus
