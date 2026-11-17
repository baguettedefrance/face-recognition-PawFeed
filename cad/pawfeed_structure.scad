// =====================================================================
//  PawFeed - structure complete imprimee en 3D (OpenSCAD, parametrique)
//  Unites : mm.  Repere : X = largeur, Y = profondeur (y=0 : mur), Z = haut
// =====================================================================
//  part : piece a afficher / exporter
//   "assemblage" "eclate"
//   "socle_lest" "bouchon_lest" "boitier_elec" "corps" "virole" "tremie"
//   "couvercle" "deflecteur" "bac_gamelle" "rampe" "bloc_vis" "vis"
//   "capuchon" "support_camera" "capot_camera" "facade_camera"
//   "test_moyeu" "test_camera" "test_emboitement" "test_ecrou"
part = "assemblage";
//  pose : "impression" (piece posee sur le plateau) ou "assemblage" (en place)
pose = "impression";

/* ---------- Enveloppe generale ---------- */
L   = 230;      // largeur
P   = 165;      // profondeur du corps (hors bac gamelle)
R   = 10;       // rayon des aretes verticales
ep  = 2.4;      // epaisseur des coques
ep_s = 3;       // epaisseur socle / boitier electronique
$fn = 64;

/* ---------- Jeux ---------- */
jeu_s = 0.2;    // ajustement serre
jeu_c = 0.4;    // ajustement coulissant

/* ---------- Niveaux (Z) ---------- */
zB = 50;        // dessus du socle leste = dessous boitier electronique
zC = 92;        // dessous du corps (= couvercle du boitier electronique)
zD = 178;       // dessous de la virole
zE = 300;       // dessus de la virole = epaulement de la tremie
h_bande = 40;   // bande verticale haute de la tremie
zT = zE + h_bande;  // dessus tremie = dessous couvercle

/* ---------- Gamelle (A ADAPTER si besoin) ---------- */
gam_d   = 160;  // diametre haut de la gamelle
gam_h   = 60;   // hauteur maxi
gam_jeu = 5;    // jeu au diametre
gam_anneau_h = 18;  // hauteur de l'anneau de maintien

/* ---------- Vis sans fin (proto x1,35) ---------- */
vis_d    = 46;      // diametre des filets (proto 34)
vis_pas  = 34;      // pas (proto 25)
vis_ame  = 10;      // diametre de l'ame (proto 6)
vis_ep   = 2.5;     // epaisseur du filet au bord (proto 2,25)
vis_jeu  = 2;       // jeu radial vis / tube (proto 2)
tube_di  = vis_d + 2*vis_jeu;   // 50
// --- moyeu : COTES DU PROTO, NE PAS MODIFIER ---
moy_d    = 15;      // diametre exterieur du moyeu
moy_h    = 4.2;     // hauteur du moyeu
moy_al_d = 5.15;    // alesage : diametre
moy_al_m = 3.15;    // alesage : cote sur meplats
moy_al_p = 6.5;     // alesage : profondeur
pion_d   = 6;       // pion de guidage cote capuchon
pion_l   = 6.5;
pion_al  = 6.6;     // alesage du palier dans le capuchon (proto)
pion_al_p = 7.2;

/* ---------- Bloc de vis ---------- */
z_axe   = 146;      // hauteur de l'axe de la vis
y_mot   = 70;       // face d'appui du moteur
bl_l    = 56;       // largeur du bloc
bl_haut = 32;       // axe -> dessus
bl_bas  = 28;       // axe -> dessous
bl_L    = 144;      // longueur du bloc
// --- fixation moteur : COTES DU PROTO ---
mot_paroi   = 6;    // epaisseur de la paroi moteur
mot_axe_d   = 9.4;  // passage du bossage moteur
mot_lam_d   = 17;   // lamage du moyeu
mot_lam_p   = 2;
mot_vis_d   = 2.7;  // avant-trous des vis M3 du moteur
mot_entraxe = 35;
mot_decal   = 8;    // decalage axe / trous
// --- entree / sortie ---
ent_y0 = 15; ent_y1 = 60; ent_l = 40;   // entree (repere bloc) : 45 x 40
sor_y0 = 98; sor_y1 = 128; sor_l = 40;  // sortie : 30 x 40
cap_emb = 14;       // longueur d'emboitement du capuchon (proto 6,2)
cap_col = 5;        // epaisseur de la collerette (proto 3)

/* ---------- Tremie ---------- */
tr_ep = 2.8;        // epaisseur (horizontale) des parois inclinees
tr_ret = 2.7;       // retrait du col sous la bande
y_ent = y_mot + (ent_y0+ent_y1)/2;   // centre de l'entree

/* ---------- Raspberry Pi 4 / ULN2003 ---------- */
pi_ex = 58; pi_ey = 49;     // entraxes des trous M2.5
pi_ent = 5;                 // hauteur des entretoises
pi_trou = 2.1;              // avant-trou vis M2.5
niche_x = 40; niche_y = 35; // niche du cable USB-C (coin arriere gauche)
uln_ex = 30; uln_ey = 27;   // entraxe des trous ULN2003 (A VERIFIER)
uln_fente = 2.5;            // largeur des fentes (vis M3 auto-taraudeuse)
uln_pos = [30, 60];         // position du 1er trou

/* ---------- Camera Arducam OV5647 IR-CUT (A VERIFIER AVANT IMPRESSION) ---------- */
cam_ex = 26; cam_ez = 26;   // entraxe des trous de la carte (estime sur photo, A MESURER)
cam_obj_d = 17;             // trou d'objectif
cam_carte_dz = -1.5;        // centre de la carte par rapport a l'objectif (connecteur de nappe EN HAUT)
// positions ci-dessous : par rapport au centre de la carte, vue de face, connecteur en haut
cam_led_dx = 31.7;          // LED IR : distance au centre (de chaque cote)
cam_led_dz = 0;
cam_led_d  = 22;            // trou de LED (LED mesuree 19 mm)
cam_capteurs = [[-19.9,6.1],[19.9,-6.1],[-4.1,-14.5]];   // les 3 petits capteurs (x<0 = a gauche vue de face)
cam_capt_d = 9.5;           // trou de capteur (capteur mesure 9 mm)
cam_entretoise = 6;         // distance facade -> carte
cam_larg = 96;              // largeur interieure du capot (carte + 2 cartes LED)
cam_haut = 40;              // hauteur interieure
cam_prof = 18;              // profondeur interieure
cam_visiere = 14;           // depassement de la visiere
cam_incl = 25;              // inclinaison affichee dans l'assemblage (15 a 35)
z_piv = 204;                // hauteur du pivot

/* ---------- Derives ---------- */
hB = zC - zB;
gam_ri = (gam_d + gam_jeu)/2;
gam_re = gam_ri + 4;
gam_c  = [0, P + 3 + gam_re + 0.5];
bac_p  = 180;               // profondeur du bac
ch_L = cam_larg + 2*ep; ch_H = cam_haut + 2*ep; ch_P = cam_prof + ep;
piv_y = (ch_P + ep)/2;      // pivot au milieu de la tete
sc_li = ch_L + 0.8; sc_L = sc_li + 6;
y_piv = P + 3 + 26;

vis_AB = [[100,20],[100,145],[-100,145],[-100,15]];   // vis boitier -> socle
pion_AB = [[-40,15],[40,150]];
vis_BC = [[85,150],[-85,150],[85,15],[-55,15]];       // vis corps -> boitier
pion_BC = [[0,15],[0,150]];
coins  = [[L/2-R,R],[-(L/2-R),R],[L/2-R,P-R],[-(L/2-R),P-R]];
cap_vis = [[-22,26],[22,-24]];                        // vis du capuchon (u,v)
rail_y = [85,130];

// =====================================================================
//  Outils
// =====================================================================
module rr(l,p,r){ translate([0,p/2]) offset(r=r) square([l-2*r,p-2*r],center=true); }
module contour(d=0){ translate([0,d]) rr(L-2*d, P-2*d, max(R-d,1)); }
module anneau2d(e){ difference(){ contour(); contour(e); } }
// extrusion avec retrait de 0,5 mm sur la 1re couche (anti pied d'elephant)
module pied(h){
  linear_extrude(0.5) offset(delta=-0.5) children();
  translate([0,0,0.5]) linear_extrude(h-0.5) children();
}
module hexa(af,h){ cylinder(d=af/cos(30), h=h, $fn=6); }
// fente d'ecrou M3 prisonnier, chargee par le cote +x
module fente_ecrou(l=10){ translate([-2.9,-2.9,0]) cube([l+2.9,5.8,2.8]); }
module vers(p){ translate([p[0],p[1],0]) rotate([0,0,atan2(P/2-p[1],-p[0])]) children(); }
module boite_r(l,p,h,r=3){ // boite a aretes arrondies, axe des arrondis = Y
  hull() for(sx=[-1,1],sz=[-1,1]) translate([sx*(l/2-r),0,sz*(h/2-r)])
    rotate([-90,0,0]) cylinder(r=r,h=p,$fn=24);
}

// =====================================================================
//  1. Socle leste
// =====================================================================
module socle_lest(){
  difference(){
    union(){
      pied(ep_s) contour();
      translate([0,0,ep_s]) linear_extrude(zB-ep_s) anneau2d(ep_s);
      for(p=vis_AB) translate([p[0],p[1],0]) cylinder(d=10,h=zB);
      for(p=pion_AB) translate([p[0],p[1],0]){ cylinder(d=8,h=zB); cylinder(d=5,h=zB+3); }
      for(x=[-37,37]) translate([x-1,ep_s-0.1,0]) cube([2,P-2*ep_s+0.2,zB-8]);   // cloisons
      for(x=[-80,0,80]) translate([x-6,P-ep_s-5.5,0]) cube([12,5.6,zB]);          // bossages bac
      translate([60-17,ep_s-0.1,0]) cube([34,3.1,zB]);                           // renfort bouchon
    }
    for(p=vis_AB){
      translate([p[0],p[1],zB-12]) cylinder(d=3.4,h=13,$fn=20);
      translate([0,0,zB-7.6]) vers(p) fente_ecrou(8);
      translate([p[0],p[1],-0.01]) cylinder(d=10.6,h=1.01);     // patins
    }
    for(x=[-80,0,80]){
      translate([x,P+1,28]) rotate([90,0,0]) cylinder(d=3.4,h=12,$fn=20);
      translate([x,P-ep_s-5.51,28]) rotate([-90,0,0]) hexa(5.6,2.8);
    }
    translate([60,-1,34]) rotate([-90,0,0]) cylinder(d=22,h=10);
    translate([60,-1,34]) rotate([-90,0,0]) cylinder(d=28.4,h=3);
  }
}
module bouchon_lest(){   // repere : collerette en z=0
  difference(){
    union(){ cylinder(d=27.6,h=1.8); translate([0,0,1.8]) cylinder(d1=22.0,d2=21.4,h=5); }
    translate([10,-3,-0.01]) cube([5,6,1]);
  }
}

// =====================================================================
//  2. Boitier electronique
// =====================================================================
module contourB(d=0){
  difference(){ contour(d); translate([-L/2-1,-1]) square([niche_x+1+d, niche_y+1+d]); }
}
pi_o = [-L/2+ep_s+1.5, niche_y+ep_s+1.5];     // coin de la carte Pi (cote microSD / USB-C)
module boitier_elec(){
  translate([0,0,zB]) difference(){
    union(){
      pied(ep_s) contour();
      translate([0,0,ep_s]) linear_extrude(hB-ep_s) difference(){ contourB(); contourB(ep_s); }
      for(p=vis_BC) translate([p[0],p[1],0]) cylinder(d=10,h=hB);
      for(p=pion_BC) translate([p[0],p[1],0]){ cylinder(d=8,h=hB); cylinder(d=5,h=hB+2.4); }
      // entretoises Pi
      for(dx=[0,pi_ex],dy=[0,pi_ey]) translate([pi_o[0]+3.5+dx,pi_o[1]+3.5+dy,0]) cylinder(d=6,h=ep_s+pi_ent,$fn=24);
      // ULN2003 : 2 bossages a fente (diagonale) + 2 appuis
      translate([uln_pos[0],uln_pos[1],ep_s+3]) cube([18,9,6],center=true);
      translate([uln_pos[0]+uln_ex,uln_pos[1]+uln_ey,ep_s+3]) cube([9,18,6],center=true);
      translate([uln_pos[0]+uln_ex,uln_pos[1],0]) cylinder(d=7,h=ep_s+6,$fn=24);
      translate([uln_pos[0],uln_pos[1]+uln_ey,0]) cylinder(d=7,h=ep_s+6,$fn=24);
      // serre-cable (collier) dans la niche
      translate([-L/2+12,8,0]) cube([14,3,ep_s+12]);
    }
    for(p=vis_AB) translate([p[0],p[1],-1]) cylinder(d=3.4,h=6,$fn=20);
    for(p=pion_AB) translate([p[0],p[1],-1]) cylinder(d=5.4,h=6,$fn=24);
    for(p=vis_BC){
      translate([p[0],p[1],hB-12]) cylinder(d=3.4,h=13,$fn=20);
      translate([0,0,hB-7.6]) vers(p) fente_ecrou(8);
    }
    for(dx=[0,pi_ex],dy=[0,pi_ey]) translate([pi_o[0]+3.5+dx,pi_o[1]+3.5+dy,1]) cylinder(d=pi_trou,h=10,$fn=16);
    translate([uln_pos[0],uln_pos[1],ep_s+3.5]) cube([10,uln_fente,6],center=true);
    translate([uln_pos[0]+uln_ex,uln_pos[1]+uln_ey,ep_s+3.5]) cube([uln_fente,10,6],center=true);
    translate([-L/2+12+4.5,7,ep_s+5]) cube([5,5,2.5]);
    // USB-C (dans la paroi de la niche, vers l'arriere)
    translate([pi_o[0]+11.2-6.5, niche_y-1, ep_s+pi_ent+1.6+1.6-4]) cube([13,ep_s+2,8]);
    // microSD (paroi gauche)
    translate([-L/2-1, pi_o[1]+28-8, ep_s+0.5]) cube([ep_s+2,16,7]);
    // aerations : parois gauche et droite uniquement
    for(i=[0:7]) translate([L/2-ep_s-1, 45+i*11, 13]) cube([ep_s+2,2,22]);
    for(i=[0:4]) translate([-L/2-1, 100+i*11, 13]) cube([ep_s+2,2,22]);
  }
}

// =====================================================================
//  3. Corps (berceau du bloc de vis, logement moteur)
// =====================================================================
module corps(){
  hC = zD - zC;
  difference(){
    union(){
      translate([0,0,zC]) pied(ep) contour();
      translate([0,0,zC+ep]) linear_extrude(hC-ep) anneau2d(ep);
      for(c=coins) translate([c[0],c[1],zC]){ cylinder(r=R-ep+0.1,h=hC); cylinder(d=6,h=hC+2.4,$fn=24); }
      // rails du bloc de vis
      for(s=[-1,1]) translate([s>0?bl_l/2-5.6:-41, y_mot, zC]) cube([41-bl_l/2+5.6, P-ep-y_mot+0.1, z_axe-bl_bas-zC]);
    }
    for(p=vis_BC) translate([p[0],p[1],zC-1]) cylinder(d=3.4,h=6,$fn=20);
    for(p=pion_BC) translate([p[0],p[1],zC-1]) cylinder(d=5.4,h=6,$fn=24);
    for(c=coins){
      translate([c[0],c[1],zD-14]) cylinder(d=3.4,h=18,$fn=20);
      translate([0,0,zD-7.6]) vers(c) fente_ecrou(9);
    }
    // passage du nez du bloc (ouvert vers le haut)
    translate([-bl_l/2-jeu_c, P-ep-1, z_axe-bl_bas-jeu_c]) cube([bl_l+2*jeu_c, ep+2, 100]);
    // ecrous des rails + logements des tenons de rampe
    for(s=[-1,1]){
      for(y=rail_y){
        translate([s*34,y,z_axe-bl_bas-13]) cylinder(d=3.4,h=14,$fn=20);
        translate([s*34,y,z_axe-bl_bas-7.6]) rotate([0,0,s>0?0:180]) fente_ecrou(8);
      }
      translate([s*31-6.4, P-19, 103.6]) cube([12.8,20,6.8]);
    }
    translate([45,22,zC-1]) cube([14,7,6]);       // cable moteur
    translate([-64,150,zC-1]) cube([18,3,6]);     // nappe camera
  }
}

// =====================================================================
//  4. Virole (coque autour de la tremie, porte la camera)
// =====================================================================
module virole(){
  difference(){
    union(){
      translate([0,0,zD]) pied(zE-zD) anneau2d(ep);
      for(c=coins) translate([c[0],c[1],zD]) cylinder(r=R-ep+0.1,h=5);
      for(s=[-1,1]) translate([s*30-6, P-ep-4.5, zD]) cube([12,4.6,z_piv+6+10-zD]);
    }
    for(c=coins){
      translate([c[0],c[1],zD-1]) cylinder(d=3.4,h=8,$fn=20);
      translate([c[0],c[1],zD-0.01]) cylinder(d=6.4,h=2.6,$fn=24);
    }
    for(s=[-1,1]){
      translate([s*30,P+1,z_piv+6]) rotate([90,0,0]) cylinder(d=3.4,h=10,$fn=20);
      translate([s*30,P-ep-4.51,z_piv+6]) rotate([-90,0,0]) hexa(5.6,2.8);
    }
    translate([-9.5,P-ep-1,z_piv-16]) cube([19,ep+2,3.2]);   // nappe camera
  }
}

// =====================================================================
//  5. Tremie (entonnoir amovible), couvercle, deflecteur
// =====================================================================
col_x = ent_l - jeu_c; col_y = (ent_y1-ent_y0) - jeu_c; col_ch = 10;
module col2d(d=0){
  translate([0,y_ent]) offset(delta=-d) polygon([[-col_x/2,-col_y/2],[col_x/2,-col_y/2],
    [col_x/2,col_y/2-col_ch],[col_x/2-col_ch,col_y/2],[-col_x/2+col_ch,col_y/2],[-col_x/2,col_y/2-col_ch]]);
}
module tremie_cone(j=0){   // interieur de l'entonnoir (j = retrait supplementaire)
  hull(){
    translate([0,0,zE-6]) linear_extrude(0.01) contour(tr_ret+tr_ep+j);
    translate([0,0,zD+2]) linear_extrude(0.01) col2d(2+j);
  }
}
module cran(l,c){ rotate([45,0,0]) cube([l,c,c],center=true); }
crans = [[0,ep,0],[0,P-ep,0],[L/2-ep,P/2,90],[-L/2+ep,P/2,90]];
module tremie(){
  difference(){
    union(){
      translate([0,0,zE]) linear_extrude(h_bande) contour();
      translate([0,0,zE-6]) linear_extrude(6.01) contour(tr_ret);
      hull(){
        translate([0,0,zE-6]) linear_extrude(0.01) contour(tr_ret);
        translate([0,0,zD+2]) linear_extrude(0.01) col2d();
      }
      translate([0,0,zD-3]) linear_extrude(5.01) col2d();
    }
    translate([0,0,zE+3.2]) linear_extrude(h_bande) contour(ep);
    hull(){
      translate([0,0,zE+3.2]) linear_extrude(0.01) contour(ep);
      translate([0,0,zE-0.01]) linear_extrude(0.01) contour(tr_ret+tr_ep);
    }
    translate([0,0,zE-6]) linear_extrude(6.01) contour(tr_ret+tr_ep);
    tremie_cone();
    translate([0,0,zD-4]) linear_extrude(6.01) col2d(2);
    for(c=crans) translate([c[0],c[1],zT-6]) rotate([0,0,c[2]]) cran(14,1.5);   // rainures de clipsage
    translate([0,0,zT-0.5]) linear_extrude(1) difference(){ offset(delta=1) contour(); offset(delta=-0.5) contour(); }
  }
}
lv = ep + jeu_s;     // retrait de la levre du couvercle
module couvercle(){
  difference(){
    union(){
      translate([0,0,zT+3]) mirror([0,0,1]) pied(3) contour();
      translate([0,0,zT-12]) linear_extrude(12.01) difference(){ contour(lv); contour(lv+2); }
      for(c=crans) translate([c[0]+(c[2]==90?(c[0]>0?-jeu_s:jeu_s):0), c[1]+(c[2]==0?(c[1]<P/2?jeu_s:-jeu_s):0), zT-6])
        rotate([0,0,c[2]]) cran(10,1.0);
      translate([0,P/2,zT-14]) linear_extrude(14.01) difference(){ square([64,26],center=true); square([60,22],center=true); }
      translate([-32,P/2-13,zT-14]) cube([64,26,2]);
    }
    translate([0,P/2,zT-11.9]) linear_extrude(20) square([60,22],center=true);
  }
  translate([-4,P/2-12,zT]) cube([8,24,3]);    // barrette de prehension
}
z_defl = zD + 29;
module deflecteur(){
  intersection(){
    translate([0,P,z_defl]) rotate([90,0,0]) linear_extrude(P)
      difference(){ polygon([[-15,0],[15,0],[0,17.9]]); polygon([[-11.9,-0.01],[11.9,-0.01],[0,14.2]]); }
    tremie_cone(jeu_c);
  }
}

// =====================================================================
//  6. Bac de gamelle
// =====================================================================
module bac2d(){ translate([0,P]) rr(L,bac_p,R); }
module bac_gamelle(){
  difference(){
    union(){
      pied(3) bac2d();
      translate([0,0,3]) linear_extrude(7) difference(){ bac2d(); offset(delta=-3) bac2d(); }
      translate([-L/2+R,P,0]) cube([L-2*R,3,36]);
      translate([gam_c[0],gam_c[1],0]) difference(){
        cylinder(r=gam_re,h=3+gam_anneau_h,$fn=120);
        translate([0,0,3]) cylinder(r=gam_ri,h=gam_anneau_h+1,$fn=120);
      }
    }
    for(s=[-1,1]) translate([s*(gam_ri+2),gam_c[1],3+6+20]) cube([14,34,40],center=true);  // prises de doigts
    for(x=[-80,0,80]) translate([x,P+4,28]) rotate([90,0,0]) cylinder(d=3.4,h=6,$fn=20);
    for(s=[-1,1]) translate([s*95,P+bac_p-15,-0.01]) cylinder(d=10.6,h=1.01);
  }
}

// =====================================================================
//  7. Rampe de sortie (amovible, 35 deg)
// =====================================================================
r_y0 = P+1; r_y1 = 218; r_z0 = 107; r_p = tan(35);
function rz(y) = r_z0 - r_p*(y-r_y0);
module yz(h){ rotate([90,0,90]) linear_extrude(h,center=true) children(); }
module rampe(){
  yz(55) polygon([[r_y0,r_z0],[r_y1,rz(r_y1)],[r_y1,rz(r_y1)-3.05],[r_y0,r_z0-3.05]]);
  for(s=[-1,1]){
    translate([s*26.25,0,0]) yz(2.5) polygon([[r_y0,r_z0-3.05],[r_y1,rz(r_y1)-3.05],[r_y1,rz(r_y1)+14.6],
      [r_y0+(r_z0+14.6-117)/r_p,117],[r_y0,117]]);
    // tenons
    translate([s*31-6, P-17.5, 104]) cube([12, 22.5, 6]);
    hull(){
      translate([s*31-6, r_y0, 104]) cube([12,4,6]);
      translate([s*26.25-1.25, r_y0+14, 104]) cube([2.5,0.1,6]);
    }
  }
}

// =====================================================================
//  8. Bloc de vis, vis, capuchon   (repere bloc : Z = axe, z=0 = face moteur,
//     point (u,v) de la section -> [u,-v] ; v>0 = vers le haut une fois monte)
// =====================================================================
module profil_bloc(){ translate([-bl_l/2,-bl_haut]) offset(r=3) offset(delta=-3) square([bl_l,bl_haut+bl_bas]); }
module fenetre(y0,y1,l,ch=10){ polygon([[-l/2,y0],[l/2,y0],[l/2,y1-ch],[l/2-ch,y1],[-l/2+ch,y1],[-l/2,y1-ch]]); }
module bloc_vis(){
  difference(){
    union(){
      pied(bl_L) profil_bloc();
      pied(90) translate([-40,bl_bas-5]) square([80,5]);          // pattes de fixation
    }
    translate([0,0,mot_paroi]) cylinder(d=tube_di,h=bl_L,$fn=96);
    translate([0,0,bl_L-2]) cylinder(d1=tube_di,d2=tube_di+4.2,h=2.1,$fn=96);
    translate([0,0,-1]) cylinder(d=mot_axe_d,h=mot_paroi+2,$fn=48);
    translate([0,0,mot_paroi-mot_lam_p]) cylinder(d=mot_lam_d,h=mot_lam_p+1,$fn=48);
    for(s=[-1,1]) translate([s*mot_entraxe/2,-mot_decal,-0.01]) cylinder(d=mot_vis_d,h=5,$fn=20);
    translate([0,-5,0]) rotate([90,0,0]) linear_extrude(bl_haut) fenetre(ent_y0,ent_y1,ent_l);   // entree
    translate([0,bl_bas+1,0]) rotate([90,0,0]) linear_extrude(bl_bas-4) fenetre(sor_y0,sor_y1,sor_l); // sortie
    for(c=cap_vis){
      translate([c[0],-c[1],bl_L-16]) cylinder(d=3.4,h=17,$fn=20);
      translate([c[0],-c[1],bl_L-10.8]) rotate([0,0,c[1]>0?-90:90]) fente_ecrou(10);
    }
    for(s=[-1,1],y=rail_y) translate([s*34,bl_bas+1,y-y_mot]) rotate([90,0,0]) cylinder(d=3.4,h=8,$fn=20);
  }
}
module helice(){
  N = 60; rc = vis_ame/2-0.5; Rv = vis_d/2; z0 = vis_ep + (Rv-rc);
  n = ceil((vis_L - z0 + vis_ep + 1)/vis_pas*N) + 1;
  pts = [for(i=[0:n]) let(a=i*360/N, zt=z0+vis_pas*i/N) each [
      [rc*cos(a),rc*sin(a),zt-vis_ep-(Rv-rc)], [Rv*cos(a),Rv*sin(a),zt-vis_ep],
      [Rv*cos(a),Rv*sin(a),zt], [rc*cos(a),rc*sin(a),zt] ]];
  fcs = concat(
    [[0,3,2],[0,2,1]], [[4*n,4*n+1,4*n+2],[4*n,4*n+2,4*n+3]],
    [for(i=[0:n-1],k=[0:3]) let(a=4*i+k, b=4*i+(k+1)%4) each [[a,b,b+4],[a,b+4,a+4]]]);
  polyhedron(pts,fcs,convexity=10);
}
vis_L = bl_L - cap_emb - 0.5 - (mot_paroi-mot_lam_p);    // longueur du corps de vis
module vis(){   // repere : z=0 = face du moyeu (cote moteur)
  difference(){
    union(){
      cylinder(d=moy_d,h=moy_h,$fn=64);
      cylinder(d=vis_ame,h=vis_L,$fn=48);
      translate([0,0,vis_L]) cylinder(d=pion_d,h=pion_l,$fn=48);
      intersection(){ helice(); cylinder(d=vis_d+2,h=vis_L); }
    }
    translate([0,0,-0.01]) linear_extrude(moy_al_p) intersection(){ circle(d=moy_al_d,$fn=48); square([moy_al_m,moy_al_d+1],center=true); }
  }
}
module capuchon(){   // repere bloc
  difference(){
    union(){
      translate([0,0,bl_L+cap_col]) mirror([0,0,1]) pied(cap_col) union(){
        profil_bloc();
        translate([bl_l/2-4,-8]) offset(r=3) offset(delta=-3) square([14,16]);    // oreille de prehension
      }
      translate([0,0,bl_L-cap_emb+0.6]) cylinder(d=tube_di-2*jeu_s,h=cap_emb-0.59,$fn=96);
      translate([0,0,bl_L-cap_emb]) cylinder(d1=tube_di-2*jeu_s-1.2,d2=tube_di-2*jeu_s,h=0.61,$fn=96);
      translate([0,0,bl_L-1.8]) cylinder(d1=tube_di-2*jeu_s,d2=tube_di+3,h=1.81,$fn=96);   // conge
    }
    translate([0,0,bl_L-cap_emb-0.01]) cylinder(d=pion_al,h=pion_al_p,$fn=48);
    for(c=cap_vis) translate([c[0],-c[1],bl_L-1]) cylinder(d=3.4,h=cap_col+2,$fn=20);
  }
}
module en_place(){ translate([0,y_mot,z_axe]) rotate([-90,0,0]) children(); }

// =====================================================================
//  9. Camera : support fixe, capot (tete inclinable), facade interchangeable
// =====================================================================
module support_camera(){
  difference(){
    union(){
      translate([-sc_L/2,P,z_piv-23]) cube([sc_L,3,51.5]);
      for(s=[-1,1]) hull(){
        translate([s*(sc_li/2+1.5),y_piv,z_piv]) rotate([0,90,0]) cylinder(d=18,h=3,center=true,$fn=32);
        translate([s*(sc_li/2+1.5)-1.5,P,z_piv-12]) cube([3,3,40.5]);
      }
      translate([-sc_L/2,P,z_piv+25.5]) cube([sc_L,29,3]);
    }
    translate([0,y_piv,z_piv]) rotate([0,90,0]) cylinder(d=3.4,h=sc_L+2,center=true,$fn=20);
    for(s=[-1,1]) translate([s*30,P+4,z_piv+6]) rotate([90,0,0]) cylinder(d=3.4,h=6,$fn=20);
    translate([-9.5,P-1,z_piv-16]) cube([19,5,3.2]);
  }
}
module capot_camera(){   // repere tete : y=0 = dos, x et z centres
  bx = cam_larg/2-2.5;
  difference(){
    union(){
      difference(){
        union(){
          boite_r(ch_L,ch_P,ch_H);
          translate([-ch_L/2+3,ch_P-1,ch_H/2-ep]) cube([ch_L-6,ep+cam_visiere+1,ep]);   // visiere
        }
        translate([-cam_larg/2,ep,-cam_haut/2]) cube([cam_larg,cam_prof+1,cam_haut]);
      }
      for(sx=[-1,1]){
        for(sz=[-1,1]) translate([sx*bx-2.5,ep-0.1,sz*(cam_haut/2-2.5)-2.5]) cube([5,cam_prof+0.1,5]);
        translate([sx*bx-2.5,ep-0.1,-5]) cube([5,cam_prof+0.1,10]);
      }
    }
    for(sx=[-1,1]){
      for(sz=[-1,1]) translate([sx*bx,ch_P-10,sz*(cam_haut/2-2.5)]) rotate([-90,0,0]) cylinder(d=2.7,h=11,$fn=16);
      translate([sx*(ch_L/2+1),piv_y,0]) rotate([0,-sx*90,0]) cylinder(d=3.4,h=10,$fn=20);
      translate([sx*(cam_larg/2-5.01),piv_y,0]) rotate([0,sx*90,0]) hexa(5.6,2.8);
    }
    translate([-9.5,-1,-cam_haut/2]) cube([19,ep+2,3.2]);   // nappe
  }
}
module facade_camera(e=ep, ent=cam_entretoise){   // repere tete
  bx = cam_larg/2-2.5; cz = cam_carte_dz;
  difference(){
    union(){
      translate([0,ch_P,-(ep+jeu_s)/2]) boite_r(ch_L,e,ch_H-ep-jeu_s);   // passe sous la visiere
      for(sx=[-1,1],sz=[-1,1]) translate([sx*cam_ex/2,ch_P-ent,cz+sz*cam_ez/2]) rotate([-90,0,0]) cylinder(d=5,h=ent+0.1,$fn=24);
    }
    for(sx=[-1,1],sz=[-1,1]){
      translate([sx*cam_ex/2,ch_P-ent-1,cz+sz*cam_ez/2]) rotate([-90,0,0]) cylinder(d=1.7,h=ent+1+min(e-0.8,1),$fn=12);
      translate([sx*bx,ch_P-1,sz*(cam_haut/2-2.5)]) rotate([-90,0,0]) cylinder(d=3.4,h=e+2,$fn=20);
    }
    translate([0,ch_P-1,0]) rotate([-90,0,0]) cylinder(d=cam_obj_d,h=e+2);
    for(sx=[-1,1]) translate([sx*cam_led_dx,ch_P-1,cz+cam_led_dz]) rotate([-90,0,0]) cylinder(d=cam_led_d,h=e+2,$fn=48);
    for(c=cam_capteurs) translate([-c[0],ch_P-1,cz+c[1]]) rotate([-90,0,0]) cylinder(d=cam_capt_d,h=e+2,$fn=32);
  }
}
module tete_en_place(){ translate([0,y_piv,z_piv]) rotate([-cam_incl,0,0]) translate([0,-piv_y,0]) children(); }

// =====================================================================
//  10. Pieces de test
// =====================================================================
module test_moyeu(){
  difference(){
    cylinder(d=moy_d,h=8);
    translate([0,0,-0.01]) linear_extrude(moy_al_p) intersection(){ circle(d=moy_al_d,$fn=48); square([moy_al_m,moy_al_d+1],center=true); }
  }
}
module test_emboitement(){
  difference(){ cylinder(d=tube_di+6,h=10,$fn=96); translate([0,0,-1]) cylinder(d=tube_di,h=12,$fn=96); }
  translate([tube_di+12,0,0]){ cylinder(d=tube_di+6,h=2,$fn=96); cylinder(d=tube_di-2*jeu_s,h=10,$fn=96); }
}
module test_ecrou(){
  difference(){
    translate([-8,-8,0]) cube([22,16,14]);
    translate([0,0,2]) cylinder(d=3.4,h=13,$fn=20);
    translate([0,0,6.4]) fente_ecrou(10);
    translate([-9,0,7]) rotate([0,90,0]) cylinder(d=3.4,h=30,$fn=20);
    translate([14.01,0,7]) rotate([0,-90,0]) hexa(5.6,2.8);
  }
}

// =====================================================================
//  Fantomes (non imprimes) pour l'assemblage
// =====================================================================
module moteur(){ color("silver") en_place(){
  translate([0,-mot_decal,-19]) cylinder(d=28,h=19);
  translate([0,-mot_decal,-1]) hull() for(s=[-1,1]) translate([s*mot_entraxe/2,0,0]) cylinder(d=7,h=1);
  cylinder(d=5,h=10);
}}
module gamelle(){ color("gainsboro") translate([gam_c[0],gam_c[1],3.2]) difference(){
  cylinder(d1=gam_d-40,d2=gam_d,h=gam_h); translate([0,0,2]) cylinder(d1=gam_d-44,d2=gam_d-4,h=gam_h); } }

// =====================================================================
//  Aiguillage
// =====================================================================
module piece(n){   // en position d'assemblage
  if(n=="socle_lest") socle_lest();
  if(n=="bouchon_lest") translate([60,0,34]) rotate([-90,0,0]) bouchon_lest();
  if(n=="boitier_elec") boitier_elec();
  if(n=="corps") corps();
  if(n=="virole") virole();
  if(n=="tremie") tremie();
  if(n=="couvercle") couvercle();
  if(n=="deflecteur") deflecteur();
  if(n=="bac_gamelle") bac_gamelle();
  if(n=="rampe") rampe();
  if(n=="bloc_vis") en_place() bloc_vis();
  if(n=="vis") en_place() translate([0,0,mot_paroi-mot_lam_p]) vis();
  if(n=="capuchon") en_place() capuchon();
  if(n=="support_camera") support_camera();
  if(n=="capot_camera") tete_en_place() capot_camera();
  if(n=="facade_camera") tete_en_place() facade_camera();
}
module piece_imp(n){   // posee sur le plateau
  if(n=="socle_lest") socle_lest();
  if(n=="bouchon_lest") bouchon_lest();
  if(n=="boitier_elec") translate([0,0,-zB]) boitier_elec();
  if(n=="corps") translate([0,0,-zC]) corps();
  if(n=="virole") translate([0,0,-zD]) virole();
  if(n=="tremie") translate([0,0,zT]) rotate([180,0,0]) tremie();
  if(n=="couvercle") translate([0,0,zT+3]) rotate([180,0,0]) couvercle();
  if(n=="deflecteur") translate([0,0,-z_defl]) deflecteur();
  if(n=="bac_gamelle") bac_gamelle();
  if(n=="rampe") translate([0,0,r_y1]) rotate([-90,0,0]) rampe();
  if(n=="bloc_vis") bloc_vis();
  if(n=="vis") vis();
  if(n=="capuchon") translate([0,0,bl_L+cap_col]) rotate([180,0,0]) capuchon();
  if(n=="support_camera") translate([0,0,-P]) rotate([90,0,0]) support_camera();
  if(n=="capot_camera") rotate([90,0,0]) capot_camera();
  if(n=="facade_camera") translate([0,0,ch_P+ep]) rotate([-90,0,0]) facade_camera();
  if(n=="test_moyeu") test_moyeu();
  if(n=="test_camera") translate([0,0,ch_P+1.2]) rotate([-90,0,0]) facade_camera(1.2,2);
  if(n=="test_emboitement") test_emboitement();
  if(n=="test_ecrou") test_ecrou();
}
// [nom, couleur, deplacement en vue eclatee]
liste = [
  ["socle_lest","#222222",[0,0,-60]], ["bouchon_lest","#222222",[0,-40,-60]],
  ["boitier_elec","#2a6fdb",[0,0,-20]], ["corps","#f2f2f2",[0,0,20]],
  ["virole","#2a6fdb",[0,0,90]], ["tremie","#111111",[0,0,190]],
  ["couvercle","#f2f2f2",[0,0,250]], ["deflecteur","#111111",[0,0,215]],
  ["bac_gamelle","#222222",[0,60,-60]], ["rampe","#111111",[0,90,0]],
  ["bloc_vis","#111111",[0,0,55]], ["vis","#333333",[0,150,55]],
  ["capuchon","#111111",[0,210,55]], ["support_camera","#222222",[0,50,90]],
  ["capot_camera","#222222",[0,95,90]], ["facade_camera","#222222",[0,125,90]] ];
module assemblage(k=0){
  for(p=liste) translate(k*p[2]) color(p[1]) piece(p[0]);
  translate(k*[0,0,55]) moteur();
  translate(k*[0,60,-60]) gamelle();
}
if(part=="assemblage") assemblage(0);
else if(part=="eclate") assemblage(1);
else if(pose=="assemblage") piece(part);
else piece_imp(part);
