From: Michel Lespinasse <walken@google.com>
Date: Wed, 09 Mar 2011 13:09:09 +0000
Subject: Re: [PATCH 0/5] make *_gate_vma accept mm_struct instead of task_struct
Message-Id: <AANLkTikTEi8uKeCfPLoenNx9g6fLyAqNqfVdR=4KzNB3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
In-Reply-To: <1299630721-4337-1-git-send-email-wilsons@start.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Wilson <wilsons@start.ca>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Tue, Mar 8, 2011 at 4:31 PM, Stephen Wilson <wilsons@start.ca> wrote:
> Morally, the question of whether an address lies in a gate vma should be =
asked
> with respect to an mm, not a particular task.
>
> Practically, dropping the dependency on task_struct will help make curren=
t and
> future operations on mm's more flexible and convenient. =A0In particular,=
 it
> allows some code paths to avoid the need to hold task_lock.

Reviewed-by: Michel Lespinasse <walken@google.com>

May I suggest ia32_compat instead of just compat for the flag name ?

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
