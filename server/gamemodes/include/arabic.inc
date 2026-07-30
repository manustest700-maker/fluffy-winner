// ===========================================================================
//  arabic.inc  -  server-side Arabic shaping for SA-MP (Windows-1256 client)
//  AUTO-GENERATED from arabic_table.json  -  do not edit by hand.
//  Converts logical CP1256 Arabic -> connected presentation forms + RTL,
//  byte-encoded to match the client font (arabic_v2.ttf).
// ===========================================================================
#if defined _arabic_inc
    #endinput
#endif
#define _arabic_inc

#if !defined AR_MAXBUF
    #define AR_MAXBUF (4096)
#endif

static const g_arLetter[256] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
static const g_arDual[256]   = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
static const g_arGlyph[256]  = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
static const g_arForm[256][4] = {
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {250, 250, 250, 250},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {220, 221, 222, 223},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {254, 254, 254, 254},
    {128, 128, 128, 129},
    {130, 130, 130, 131},
    {132, 132, 132, 133},
    {134, 134, 134, 135},
    {136, 137, 138, 139},
    {240, 240, 240, 140},
    {224, 141, 142, 143},
    {252, 252, 252, 144},
    {238, 145, 146, 147},
    {243, 148, 149, 150},
    {245, 151, 153, 154},
    {231, 155, 156, 157},
    {249, 158, 159, 160},
    {232, 232, 232, 162},
    {236, 236, 236, 163},
    {241, 241, 241, 164},
    {247, 247, 247, 165},
    {251, 166, 167, 168},
    {244, 169, 170, 171},
    {246, 172, 173, 174},
    {233, 175, 176, 177},
    {0, 0, 0, 0},
    {253, 178, 179, 180},
    {255, 181, 182, 183},
    {227, 184, 185, 187},
    {237, 188, 189, 190},
    {0, 0, 0, 0},
    {229, 192, 193, 194},
    {234, 195, 196, 197},
    {230, 198, 199, 200},
    {0, 0, 0, 0},
    {239, 201, 202, 203},
    {0, 0, 0, 0},
    {228, 204, 205, 206},
    {235, 207, 208, 209},
    {248, 210, 211, 212},
    {242, 242, 242, 213},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {225, 214, 215, 216},
    {226, 217, 218, 219},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0} 
};

// Dialog re-encoding table (cp1251 output byte -> cp1252 dialog byte).
// Identity for almost every byte; relocates a few common forms onto
// Latin-1 codepoints so the cp1252 ImGui dialog renderer shows correct
// Arabic.  Applied ONLY to ShowPlayerDialog text, never to chat/3D.
static const g_arDlg[256] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 250, 152, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 220, 142, 221, 222, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 223, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 63, 63, 63, 63, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 63, 251, 252, 253, 254, 255 };


// Reshape one string: logical CP1256 -> presentation forms + RTL into dst.
stock Ar_Process(const src[], dst[], size)
{
    new n = strlen(src);
    if (n <= 0) { dst[0] = 0; return 0; }

    // fast path: nothing arabic -> copy through unchanged
    new has = 0, i;
    for (i = 0; i < n; i++) if (g_arLetter[src[i] & 0xFF]) { has = 1; break; }
    if (!has)
    {
        for (i = 0; i < n && i < size - 1; i++) dst[i] = src[i];
        dst[i] = 0;
        return i;
    }

    // 1) contextual shaping (logical order)
    static tmp[AR_MAXBUF];
    new m = 0;
    for (i = 0; i < n && m < AR_MAXBUF - 1; i++)
    {
        new c = src[i] & 0xFF;
        if (g_arLetter[c])
        {
            new pc = (i > 0)     ? (src[i-1] & 0xFF) : 0;
            new nc = (i < n - 1) ? (src[i+1] & 0xFF) : 0;
            new back = (g_arLetter[pc] && g_arDual[pc]) ? 1 : 0;
            new fwd  = (g_arDual[c]  && g_arLetter[nc]) ? 1 : 0;
            new pos  = (back && fwd) ? 2 : back ? 3 : fwd ? 1 : 0;
            tmp[m++] = g_arForm[c][pos];
        }
        else tmp[m++] = c;
    }

    // 2) reverse arabic runs (absorb interior spaces/digits); keep numbers LTR
    new w = 0;
    i = 0;
    while (i < m && w < size - 1)
    {
        new b = tmp[i];
        if (g_arGlyph[b])
        {
            new j = i + 1;
            while (j < m)
            {
                new bb = tmp[j];
                if (g_arGlyph[bb]) { j++; continue; }
                if (bb == ' ' || (bb >= '0' && bb <= '9'))
                {
                    new k = j;
                    while (k < m && (tmp[k] == ' ' || (tmp[k] >= '0' && tmp[k] <= '9'))) k++;
                    if (k < m && g_arGlyph[tmp[k]]) { j = k; continue; }
                }
                break;
            }
            new rs = w;
            for (new t = j - 1; t >= i && w < size - 1; t--) dst[w++] = tmp[t];
            // re-flip digit subruns so numbers read LTR
            new a = rs;
            while (a < w)
            {
                if (dst[a] >= '0' && dst[a] <= '9')
                {
                    new e = a;
                    while (e < w && dst[e] >= '0' && dst[e] <= '9') e++;
                    new lo = a, hi = e - 1;
                    while (lo < hi) { new tt = dst[lo]; dst[lo] = dst[hi]; dst[hi] = tt; lo++; hi--; }
                    a = e;
                }
                else a++;
            }
            i = j;
        }
        else { dst[w++] = b; i++; }
    }
    dst[w] = 0;
    return w;
}

// ---- ALS native hooks (defined BEFORE the macros so inner calls hit the real
//      natives; every gamemode/module call after the include is reshaped). ----

// Detect launcher control-protocol payloads such as "~INV_DATA~...", "~ACC_UI~",
// "~PHONE_UI~", etc.  These are UI data packets meant to be consumed by a custom
// client; on launchers that do not implement them they leak into chat as white
// junk text.  We drop them at the SendClientMessage chokepoint so they never
// render, without touching any visible gameplay message.
stock AR_IsCtrl(const s[])
{
    if (s[0] != '~') return 0;
    new i = 1;
    while (s[i] != 0)
    {
        new c = s[i];
        if (c == '~') return (i > 1) ? 1 : 0;
        if (!((c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '_')) return 0;
        i++;
    }
    return 0;
}

stock AR_SCM(playerid, color, const msg[])
{
    if (AR_IsCtrl(msg)) return 1;
    static b[AR_MAXBUF];
    Ar_Process(msg, b, sizeof b);
    return SendClientMessage(playerid, color, b);
}
stock AR_SCMTA(color, const msg[])
{
    if (AR_IsCtrl(msg)) return 1;
    static b[AR_MAXBUF];
    Ar_Process(msg, b, sizeof b);
    return SendClientMessageToAll(color, b);
}
stock AR_SPMTA(playerid, const msg[])
{
    static b[AR_MAXBUF];
    Ar_Process(msg, b, sizeof b);
    return SendPlayerMessageToAll(playerid, b);
}
stock AR_SPMTP(playerid, senderid, const msg[])
{
    static b[AR_MAXBUF];
    Ar_Process(msg, b, sizeof b);
    return SendPlayerMessageToPlayer(playerid, senderid, b);
}
stock AR_SPCB(playerid, const text[], color, Float:drawdistance, expiretime)
{
    static b[256];
    Ar_Process(text, b, sizeof b);
    return SetPlayerChatBubble(playerid, b, color, drawdistance, expiretime);
}
// cp1256 byte -> Unicode codepoint (authoritative, generated from the Python
// cp1256 codec).  The launcher's dialog UI (Java6JavaUI::CSAMPDialog in
// libClient.so) decodes incoming dialog text as UTF-8 via libc++ codecvt_utf8
// (the binary literally carries "invalid string: ill-formed UTF-8 byte"), so
// raw CP1256 bytes are rejected as ill-formed UTF-8 and the Arabic vanishes
// (only ASCII survives -- exactly the "blank dialog" symptom).  The dialog font
// dlgarab.ttf is a FULL Unicode Arabic font (235 U+06xx code points + a GSUB
// shaping table), and the launcher's own UTF-8 hint string "ط§ط¶ط؛ط· ظ„ظ„ط¥ط¯ط®ط§ظ„"
// renders perfectly, proving the dialog view shapes LOGICAL UTF-8 Arabic by
// itself.  Therefore AR_DlgU8 converts each CP1256 source byte to its real
// Unicode code point and UTF-8-encodes it: no pre-shaping, no reversal.  The
// launcher's Ar.dlg must be IDENTITY (it just passes this correct String to the
// TextView).  Chat is a separate path (SA-MP bitmap font) and is NOT touched.
static const g_cp1256uni[256] = {
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
    16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
    32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
    64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
    80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95,
    96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
    112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
    8364, 1662, 8218, 402, 8222, 8230, 8224, 8225, 710, 8240, 1657, 8249, 338, 1670, 1688, 1672,
    1711, 8216, 8217, 8220, 8221, 8226, 8211, 8212, 1705, 8482, 1681, 8250, 339, 8204, 8205, 1722,
    160, 1548, 162, 163, 164, 165, 166, 167, 168, 169, 1726, 171, 172, 173, 174, 175,
    176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 1563, 187, 188, 189, 190, 1567,
    1729, 1569, 1570, 1571, 1572, 1573, 1574, 1575, 1576, 1577, 1578, 1579, 1580, 1581, 1582, 1583,
    1584, 1585, 1586, 1587, 1588, 1589, 1590, 215, 1591, 1592, 1593, 1594, 1600, 1601, 1602, 1603,
    224, 1604, 226, 1605, 1606, 1607, 1608, 231, 232, 233, 234, 235, 1609, 1610, 238, 239,
    1611, 1612, 1613, 1614, 244, 1615, 1616, 247, 1617, 249, 1618, 251, 252, 8206, 8207, 1746
};
// PROVEN by the device screenshot fingerprint: the launcher's dialog UI was
// patched (q9/j.smali + SAMPDialog.smali) to decode incoming dialog text as
// windows-1256 (single byte).  Sending logical UTF-8 produced the exact garble
// "ط·ع¾ط·آ³ط·آ¬ط¸ظ¹ط¸â€‍ ط·آ¯ط·آ®ط¸ث†ط¸â€‍" -- which is precisely UTF-8 Arabic bytes re-read as
// cp1256 (cp1251 would have produced Cyrillic ذ¨/ذ©, which did NOT appear).  So
// the server must send the RAW CP1256 source bytes unchanged, and the launcher
// side Ar.dlg must be IDENTITY (it is, in the shipped APK).  The earlier "blank"
// build only looked blank because Ar.dlg still ran a 1251->1256 transform that
// turned the correctly cp1256-decoded Arabic into '?' -- not because of UTF-8.
// g_cp1256uni is retained only for reference; this passthrough does not use it.
#pragma unused g_cp1256uni
stock AR_DlgU8(const src[], dst[], size)
{
    new i = 0;
    while (src[i] != 0 && i < size - 1)
    {
        dst[i] = src[i];
        i++;
    }
    dst[i] = 0;
    return i;
}
stock AR_SPD(playerid, dialogid, style, const caption[], const info[], const button1[], const button2[])
{
    static c[1024], n[AR_MAXBUF * 3], b1[512], b2[512];
    AR_DlgU8(caption,  c,  sizeof c);
    AR_DlgU8(info,     n,  sizeof n);
    AR_DlgU8(button1,  b1, sizeof b1);
    AR_DlgU8(button2,  b2, sizeof b2);
    return ShowPlayerDialog(playerid, dialogid, style, c, n, b1, b2);
}

// ---- 3D text labels render with the SAME SA-MP bitmap font as chat (NOT the
//      Unicode dialog view), so they must be pre-shaped+reversed with the exact
//      chat pipeline (Ar_Process).  Without this they leak as logical CP1256 =
//      unshaped, mis-ordered garble.  This touches ONLY 3D-label natives; chat
//      and dialog paths are untouched and keep working as-is. ----
stock Text3D:AR_C3DTL(const text[], color, Float:x, Float:y, Float:z, Float:dd, vw, testLOS = 0)
{
    static b[AR_MAXBUF];
    Ar_Process(text, b, sizeof b);
    return Create3DTextLabel(b, color, x, y, z, dd, vw, testLOS);
}
stock PlayerText3D:AR_CP3DTL(playerid, const text[], color, Float:x, Float:y, Float:z, Float:dd, attachedplayer = INVALID_PLAYER_ID, attachedvehicle = INVALID_VEHICLE_ID, testLOS = 0)
{
    static b[AR_MAXBUF];
    Ar_Process(text, b, sizeof b);
    return CreatePlayer3DTextLabel(playerid, b, color, x, y, z, dd, attachedplayer, attachedvehicle, testLOS);
}
stock STREAMER_TAG_3D_TEXT_LABEL:AR_CD3DTL(const text[], color, Float:x, Float:y, Float:z, Float:dd, attachedplayer = INVALID_PLAYER_ID, attachedvehicle = INVALID_VEHICLE_ID, testlos = 0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_3D_TEXT_LABEL_SD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
    static b[AR_MAXBUF];
    Ar_Process(text, b, sizeof b);
    return CreateDynamic3DTextLabel(b, color, x, y, z, dd, attachedplayer, attachedvehicle, testlos, worldid, interiorid, playerid, streamdistance, areaid, priority);
}
stock AR_UD3DTLT(STREAMER_TAG_3D_TEXT_LABEL:id, color, const text[])
{
    static b[AR_MAXBUF];
    Ar_Process(text, b, sizeof b);
    return UpdateDynamic3DTextLabelText(id, color, b);
}

// GameTextForPlayer renders with the SAME SA-MP bitmap font as chat/3D labels,
// so Arabic must be pre-shaped+reversed (Ar_Process).  Non-Arabic gametext
// (style codes like ~r~~n~, English) passes through unchanged via the fast path.
stock AR_GTFP(playerid, const string[], time, style)
{
    static b[AR_MAXBUF];
    Ar_Process(string, b, sizeof b);
    return GameTextForPlayer(playerid, b, time, style);
}
stock AR_GTFA(const string[], time, style)
{
    static b[AR_MAXBUF];
    Ar_Process(string, b, sizeof b);
    return GameTextForAll(b, time, style);
}

// ALS hook chaining (stacks safely on top of any existing hook, e.g. nex-ac's
// ShowPlayerDialog -> acc_ShowPlayerDialog anti-cheat funnel).
#if defined _ALS_SendClientMessage
    #undef SendClientMessage
#else
    #define _ALS_SendClientMessage
#endif
#define SendClientMessage AR_SCM

#if defined _ALS_SendClientMessageToAll
    #undef SendClientMessageToAll
#else
    #define _ALS_SendClientMessageToAll
#endif
#define SendClientMessageToAll AR_SCMTA

#if defined _ALS_SendPlayerMessageToAll
    #undef SendPlayerMessageToAll
#else
    #define _ALS_SendPlayerMessageToAll
#endif
#define SendPlayerMessageToAll AR_SPMTA

#if defined _ALS_SendPlayerMessageToPlayer
    #undef SendPlayerMessageToPlayer
#else
    #define _ALS_SendPlayerMessageToPlayer
#endif
#define SendPlayerMessageToPlayer AR_SPMTP

#if defined _ALS_SetPlayerChatBubble
    #undef SetPlayerChatBubble
#else
    #define _ALS_SetPlayerChatBubble
#endif
#define SetPlayerChatBubble AR_SPCB

#if defined _ALS_ShowPlayerDialog
    #undef ShowPlayerDialog
#else
    #define _ALS_ShowPlayerDialog
#endif
#define ShowPlayerDialog AR_SPD

#if defined _ALS_Create3DTextLabel
    #undef Create3DTextLabel
#else
    #define _ALS_Create3DTextLabel
#endif
#define Create3DTextLabel AR_C3DTL

#if defined _ALS_CreatePlayer3DTextLabel
    #undef CreatePlayer3DTextLabel
#else
    #define _ALS_CreatePlayer3DTextLabel
#endif
#define CreatePlayer3DTextLabel AR_CP3DTL

#if defined _ALS_CreateDynamic3DTextLabel
    #undef CreateDynamic3DTextLabel
#else
    #define _ALS_CreateDynamic3DTextLabel
#endif
#define CreateDynamic3DTextLabel AR_CD3DTL

#if defined _ALS_UpdateDynamic3DTextLabelText
    #undef UpdateDynamic3DTextLabelText
#else
    #define _ALS_UpdateDynamic3DTextLabelText
#endif
#define UpdateDynamic3DTextLabelText AR_UD3DTLT

#if defined _ALS_GameTextForPlayer
    #undef GameTextForPlayer
#else
    #define _ALS_GameTextForPlayer
#endif
#define GameTextForPlayer AR_GTFP

#if defined _ALS_GameTextForAll
    #undef GameTextForAll
#else
    #define _ALS_GameTextForAll
#endif
#define GameTextForAll AR_GTFA
