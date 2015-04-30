From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 30 Apr 2015 00:28:05 +0000
Subject: Re: [PATCH 3/3] spi: Re-do the returning value of qspi_transfer_out_in
Message-Id: <55417715.7020005@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>	<1430200551-20708-4-git-send-email-cm-hiep@jinso.co.jp> <CAMuHMdVYnEiGaHzXFgH_pWmFRwWH91RQfm7RyS-XG9FvUTb_Mg@mail.gmail.com>
In-Reply-To: <CAMuHMdVYnEiGaHzXFgH_pWmFRwWH91RQfm7RyS-XG9FvUTb_Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>


On 2015年04月28日 20:07, Geert Uytterhoeven wrote:
> On Tue, Apr 28, 2015 at 7:55 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> To reduce complex of code, drop "ret" then qspi_transfer_out_in function
>> should be returned the value of "qspi_trigger_transfer_out_in" directly.
>>
>> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Thanks,


