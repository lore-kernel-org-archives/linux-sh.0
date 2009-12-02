From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 02 Dec 2009 01:35:55 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <upr6yyx6s.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Dear Matt

Thank you for your hard work !

> What size caches do the ms7724se and ecovec24 have?

ms7724se / ecovec24 are SH7724

------------------------
Table 8.1 Cache Features
------------------------

Item         Instruction Cache            Operand Cache
----------------------------------------------------------------
Capacity       32-Kbyte cache               32-Kbyte cache
Type           4-way set-associative,       4-way set-associative,
               virtual address              virtual address
               index/physical address tag   index/physical address tag
Line size      32 bytes                     32 bytes
Entries        256 entries/way              256 entries/way
Write method        -                       Copy-back/write-through selecta=
ble
Replacement    LRU (least-recently-used)    LRU (least-recently-used)

---------------------------
Table 8.2 Store Queue Features
---------------------------

Item            Store Queues
---------------------------
Capacity        32 bytes =1B$B!_=1B(B 2
Addresses       H'E000 0000 to H'E3FF FFFF
Write           Store instruction (1-cycle write)
Write-back      Prefetch instruction (PREF instruction)
Access right    When MMU is disabled: Determined by SQMD bit in MMUCR
                When MMU is enabled: Determined by PR for each page



---------------------------
Table 9.1 Secondary Cache Features
---------------------------

Features            Secondary Cache
---------------------------------------
Capacity            256 Kbytes
Structure           4-way set associative, physical address index/physical =
address tag
Line size           32 bytes
Number of entries   2048 entries/way
Write system        Write through
Replacement method  Least-recently-used (LRU) algorithm
Operating clock     (CPU operating clock)/n (n =3D 1, 2, 3, 4, 6, or 8)

> Would you mind giving this patch a whirl?

sorry, "whirl" =3D "try" ?


If I try your patch, "Kernel panic" seems go away,
but I can not login.
---------------------
...
  Looking up port of RPC 100003/2 on 192.168.10.77
  Looking up port of RPC 100005/1 on 192.168.10.77
  VFS: Mounted root (nfs filesystem) on device 0:12.
  Freeing unused kernel memory: 108k freed
* Unaligned userspace access in "rcS" pid=878 pc=3D0x2955d9fc ins=3D0x5111
* Sending SIGBUS to "rcS" due to unaligned access (PC 2955d9fc PR 295587c2)

  192.168.10.102 login: root
  Login incorrect
---------------------

I can see * lines sometimes


# I can got same result if I remove
# "l2_cache_init" from setup-sh7724.c
