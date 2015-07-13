From: dwalker@fifo99.com
Date: Mon, 13 Jul 2015 20:26:11 +0000
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is not available
Message-Id: <20150713202611.GA16525@fifo99.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
In-Reply-To: <87wpy82kqf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> 
> > You can call panic notifiers and kmsg dumpers before kdump by
> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > However, it doesn't make sense if kdump is not available.  In that
> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > you can't change the value of the parameter.
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I think it would make sense if he just replaced "kdump" with "kexec".

Daniel
