From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Jan 2014 04:47:25 +0000
Subject: Re: [PATCH V2 2/3] ARM: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <CANqRtoRhDTUksONzXp9=H=-f7wE2+WpXGj=RssWzrGTuKm=Aqw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jan 18, 2014 at 3:20 AM, Valentine Barshak
<valentine.barshak@cogentembedded.com> wrote:
> This adds internal PCI USB host clock support.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Changes in V2:
> * capitalized ARM in the subject;
> * rebased on top the latest devel tag.

This patch for PCI USB clock support seems fine to me.

Acked-by: Magnus Damm <damm@opensource.se>

It is common practice that maintainers reject code to encourage people
to do further development. I don't think that will help us in this
particular case, so I think it is best to merge this as-is but also
request you to spend your future time on DT development.

So please work on DT reference support together with CCF for PCI USB.

Simon, please pick up if you agree with me.

Thanks,

/ magnus
