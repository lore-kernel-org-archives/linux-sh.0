From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Mar 2009 09:16:22 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <aec7e5c30903090216j7c362a6ek3987c16c166d887b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2009 at 7:05 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Yes I could try if it works also if we already had the hibernation on memory
> on sh4.

FYI, I'm hacking on CONIFG_SUSPEND as well - will post that later this week.

> If you use a "mini-kernel" with several modules... when you will resume from
> hibernation at the begin
> you boots again the 'mini-kernel'... after that you restore the previous
> image and the irq line required by
> module more probably remains as it was (not-initialized).

Ok, good point. I'll add intc suspend/resume to my todo list!

Thanks!

/ magnus
