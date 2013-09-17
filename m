From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 17 Sep 2013 08:25:56 +0000
Subject: Re: [RFC PATCH REBASED 1/3] sh: Move fpu_counter into ARCH specific thread_struct
Message-Id: <20130917082556.GD12926@twins.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1379398639-27403-1-git-send-email-vgupta@synopsys.com>
 <1379398639-27403-2-git-send-email-vgupta@synopsys.com>
 <20130917080017.GC12926@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307514C36B@IN01WEMBXA.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307514C36B@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Tue, Sep 17, 2013 at 08:14:34AM +0000, Vineet Gupta wrote:
> For some reason the email to Paul bounced last time as well
> 
> --------------->8-----------------------
> lethal@linux-sh.org<mailto:lethal@linux-sh.org>>: host mail.linux-sh.org[111.68.239.195] said: 550 5.7.1
>     <lethal@linux-sh.org><mailto:lethal@linux-sh.org>... Relaying denied. Proper authentication required.
>     (in reply to RCPT TO command)
> --------------->8-----------------------
> 
> Did you get that too after sending this CCed email to him.

Yep.. :/ 
