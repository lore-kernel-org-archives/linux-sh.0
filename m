From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 09:12:35 +0000
Subject: Re: [PATCH 2/2] Remove soc_camera_platform setting from Migo-R
Message-Id: <aec7e5c30812040112x62d000e1rfd08f5d9fc28c9f8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <u1vwrm2ks.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u1vwrm2ks.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 2, 2008 at 4:42 PM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
>
> Migo-R can use ov772x camera driver in Linux 2.6.29.
> Therefore, soc_camera_platform setting is no longer needed.
> This patch remove it.
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Yeah, this is the right thing to do. Thank you.

Acked-by: Magnus Damm <damm@igel.co.jp>
