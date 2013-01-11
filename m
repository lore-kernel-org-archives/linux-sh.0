From: Michel Lespinasse <walken@google.com>
Date: Fri, 11 Jan 2013 04:03:41 +0000
Subject: Re: Current SuperH board can't boot
Message-Id: <CANN689ELMH18XUG1Uc80jyeS3hixsx=VPTV9gFx2hXZsNQvgUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vcb44gaq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vcb44gaq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 10, 2013 at 7:53 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> show_vm_unmapped_area_info: 0 1000 [29555555;7c000000) 0 0
> unmapped_area: found 29555555

Ah, got it. The issue is that most architectures define
TASK_UNMAPPED_BASE as a page aligned constant, but sh doesn't.

Changing the TASK_UNMAPPED_BASE definition to PAGE_ALIGN(TASK_SIZE /
3) should fix the issue.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
