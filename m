From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 29 Dec 2010 13:33:34 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_hdmi: fixup compile error
Message-Id: <9668ee76-6e43-43d5-a641-e0db2d4376d1@email.android.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbdzu8ra.wl%kuninori.morimoto.gx@renesas.com> <20101228150645.GG31883@opensource.wolfsonmicro.com> <20101229062555.GA12369@linux-sh.org> (sfid-20101229_062749_985456_BD4C209A)
In-Reply-To: <20101229062555.GA12369@linux-sh.org> (sfid-20101229_062749_985456_BD4C209A)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks. (Sorry about top posting, using my phone).

"Paul Mundt" <lethal@linux-sh.org> wrote:

>On Tue, Dec 28, 2010 at 03:06:46PM +0000, Mark Brown wrote:
>> On Mon, Dec 27, 2010 at 01:42:20PM +0900, Kuninori Morimoto wrote:
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > ---
>> > >> Paul
>> > 
>> > This patch is not needed for now on Paul's tree.
>> > But seems to be needed after ALSA tree merge.
>> > 
>> > >> Mark, Liam
>> > 
>> > this patch is needed on current Mark's "for-2.6.38" tree.
>> 
>> Paul, do you want to apply this or shall I?
>
>It doesn't really matter to me, but since it seems to depend on your
>merge perhaps it makes more sense to merge through the ALSA tree,
>simply
>in terms of limiting bisect damage.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
