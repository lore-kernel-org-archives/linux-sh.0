From: Rob Landley <rob@landley.net>
Date: Sat, 20 Jun 2015 21:19:55 +0000
Subject: Re: [PATCH] sh: Wire up missing syscalls
Message-Id: <5585D8FB.5070202@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <BLU436-SMTP93208A4E06C8B5CC68CA1CB9DD0@phx.gbl>
In-Reply-To: <BLU436-SMTP93208A4E06C8B5CC68CA1CB9DD0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <xili_gchen_5257@hotmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/09/2015 04:02 PM, Chen Gang wrote:
> The related warnings:
> 
>     CALL    scripts/checksyscalls.sh
>   <stdin>:1229:2: warning: #warning syscall sched_setattr not implemented [-Wcpp]
>   <stdin>:1232:2: warning: #warning syscall sched_getattr not implemented [-Wcpp]
>   <stdin>:1235:2: warning: #warning syscall renameat2 not implemented [-Wcpp]
>   <stdin>:1238:2: warning: #warning syscall seccomp not implemented [-Wcpp]
>   <stdin>:1241:2: warning: #warning syscall getrandom not implemented [-Wcpp]
>   <stdin>:1244:2: warning: #warning syscall memfd_create not implemented [-Wcpp]
>   <stdin>:1247:2: warning: #warning syscall bpf not implemented [-Wcpp]
>   <stdin>:1250:2: warning: #warning syscall execveat not implemented [-Wcpp]
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

Acked-by: Rob Landley <rob@landley.net>

I.E. I tried it and it worked for me on sh2 and sh4.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
