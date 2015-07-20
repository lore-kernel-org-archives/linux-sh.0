From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date: Mon, 20 Jul 2015 21:02:17 +0000
Subject: likely signedness bug in arch/{m32r,sh}/include/asm/thread_info.h
Message-Id: <87bnf6o84m.fsf@rasmusvillemoes.dk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Right-shifted ~0 aka -1 always gives -1 again, since gcc always does
arithmetic right shift of signed types. So the common code (one is
copy-pasted from the other)

      ti->flags = (ti->flags & (~0 >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
              | (val << TI_FLAG_FAULT_CODE_SHIFT);

doesn't actually clear any of ti->flags; it's entirely equivalent to

      ti->flags |= (val << TI_FLAG_FAULT_CODE_SHIFT);

Presumably harmless since this hasn't been noticed before.

[Surprisingly, for non-const shifts, gcc doesn't realize the shift is a
noop: unsigned g(int s) { return ~0 >> s; } compiles to

        movl    %edi, %ecx
        movl    $-1, %eax
        sarl    %cl, %eax
        ret

Since ~0 >> whatever is almost always used as a mask, probably
gcc/sparse/smatch should warn about this and suggest using 0u.]
